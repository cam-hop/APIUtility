//
//  VariableExtension.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import RxSwift

extension Variable {
    func asShareReplayLatest() -> Observable<E> {
        return asObservable().shareReplayLatestWhileConnected()
    }
}
