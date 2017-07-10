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
}
