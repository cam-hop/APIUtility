//
//  ApiService.swift
//  APIUtility
//
//  Created by DUONG VANHOP on 2017/07/07.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import RxSwift
import RxCocoa
import Himotoki
import Alamofire
import RxAlamofire

open class ApiService {
    static let shared = ApiService()
    private let scheduler: ConcurrentDispatchQueueScheduler

    public init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

    open func fetch<T: APIRequest>(_ item: T) -> Observable<T.Response> {
        var requestParams = ""
        if let params = item.parameters {
            requestParams = params.sorted { $0.0 < $1.0 }
                .map { "\($0)=\($1)" }
                .joined(separator: "&")
        }

        guard let url = URL(string: item.baseURL + item.path + requestParams) else {
            return Observable<T.Response>.empty()
        }

        return RxAlamofire.requestJSON(item.method, url, headers: item.headerFields)
            .observeOn(self.scheduler)
            .map({ (response, json) -> T.Response in
                return try item.response(from: json, urlResponse: response)
            })
    }

    open func fetchWithErr<T: APIRequest>(_ item: T) -> Observable<(T.Error?, T.Response?)> {
        return Observable.create { observer -> Disposable in
            var requestParams = ""
            if let params = item.parameters {
                requestParams = params.sorted { $0.0 < $1.0 }
                    .map { "\($0)=\($1)" }
                    .joined(separator: "&")
            }

            guard let url = URL(string: item.baseURL + item.path + requestParams) else {
                return Disposables.create()
            }

            return RxAlamofire.requestJSON(item.method, url, headers: item.headerFields)
                .subscribe(
                    onNext: { [weak self] (response, value) in
                        guard let weakSelf = self else { return }
                        // Check the response code if needed
                        if response.statusCode == 200 {
                            for header in response.allHeaderFields {
                                let responseHeader = weakSelf.headerType(header.key.description)
                                switch responseHeader {
                                case .maintenance, .forceUpdate:
                                    guard let error = try? item.errorResponse(form: value, urlResponse: response) else { return }
                                    observer.on(.next((error, nil)))
                                default:
                                    guard let result = try? item.response(from: value, urlResponse: response) else { return }
                                    observer.on(.next((nil, result)))
                                }
                            }
                        } else {
                            guard let error = try? item.errorResponse(form: value, urlResponse: response) else { return }
                            observer.on(.next((error, nil)))
                        }

                    },
                    onError: { (error) in
                        observer.on(.error(error))
                },
                    onCompleted: {
                        observer.on(.completed)
                })
            
        }
    }

    private func headerType(_ header: String) -> ResponseHeader {
        switch header {
        case "X-Force-Update":
            return .forceUpdate
        case "X-Force-Maintenance":
            return .maintenance
        default:
            return .active
        }
    }
}
