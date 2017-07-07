
//
//  SubcriberStore.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftFlux

final class SubcriberStore {
    
    static let shared = SubcriberStore()
    
    var subcribers = Variable<[Subcriber]>([])
    var deleteSub = Variable<Bool>(false)
    
    private init() {
        let fetchToken = ActionCreator.dispatcher.register(type: SubcriberAction.Fetch.self)
        guard let subcriberSbj = ActionCreator.dispatcher.dispatchSbj(type: SubcriberAction.Fetch.self, dispatchToken: fetchToken) as? DispatchSubject<SubcriberAction.Fetch.Payload> else {
            return
        }
        
        subcriberSbj.subscribe(onNext: { [unowned self] subcribers in
            self.subcribers.value = subcribers
        })
        .addDisposableTo(disposeBag)
        
    }
}
