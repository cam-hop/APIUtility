//
//  Action.swift
//  RxSwiftFlux
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import Foundation

public protocol Action {
    associatedtype Payload
    associatedtype ErrorType
    func invoke(_ dispatcher: Dispatcher)
}

public class ActionCreator {
    public static let dispatcher = DefaultDispatcher.shared
    
    public class func invoke<T: Action>(action: T) {
        action.invoke(self.dispatcher)
    }
}
