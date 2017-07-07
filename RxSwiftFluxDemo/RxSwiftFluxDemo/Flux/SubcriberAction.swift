//
//  SubcriberAction.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import RxSwift
import RxCocoa
import Himotoki
import RxSwiftFlux
import APIUtility

public let disposeBag = DisposeBag()

final class SubcriberAction {
    class Fetch: Action {
        typealias Payload = [Subcriber]
        typealias ErrorType = Error
        func invoke(_ dispatcher: Dispatcher) {
                let apiService = ApiService()
                apiService.fetch(SubcriberRequest())
                .subscribe({ event -> Void in
                    switch event {
                    case .next(let value):
                        guard let results = value.results else { return }
                        dispatcher.dispatch(action: self, result: results)
                    case .completed:
                        // do something
                        print("Completed")
                    case .error(let error):
                        
                        print("Error")
                    }
                })
                .addDisposableTo(disposeBag)
        }
    }
    
}
