//
//  Dispatcher.swift
//  RxSwiftFlux
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public typealias DispatchToken = String

public protocol Dispatcher {
    func dispatch<T: Action>(action: T, result: T.Payload)
    func dispatchErr<T: Action>(action: T, error: T.ErrorType)
    func register<T: Action>(type: T.Type) -> DispatchToken
    func unregister(_ dispatchToken: DispatchToken)
    func dispatchSbj<T: Action>(type: T.Type, dispatchToken: DispatchToken) -> AnyObject?
    func dispatchSbjErr<T: Action>(type: T.Type, dispatchToken: DispatchToken) -> AnyObject?
}

public class DefaultDispatcher: Dispatcher {
    
    public static let shared = DefaultDispatcher()
    
    private var dispatchObjs: [DispatchToken: AnyObject] = [:]
    
    private init() {}
    
    public func dispatch<T>(action: T, result: T.Payload) where T : Action {
        for dispatchToken in dispatchObjs.keys {
            if let dispatchObj = dispatchObjs[dispatchToken] as? DispatchObject<T> {
                dispatchObj.dispatchSbj.dispatch(result)
            }
        }
    }
    
    public func dispatchErr<T>(action: T, error: T.ErrorType) where T : Action {
        for dispatchToken in dispatchObjs.keys {
            if let dispatchObj = dispatchObjs[dispatchToken] as? DispatchObject<T> {
                dispatchObj.dispatchSbjErr.dispatch(error)
            }
        }
    }
    
    public func register<T>(type: T.Type) -> DispatchToken where T : Action {
        let nextDispatchToken = NSUUID().uuidString
        let dispatchSbj = DispatchSubject<T.Payload>()
        let dispatchSbjErr = DispatchSubject<T.ErrorType>()
        dispatchObjs[nextDispatchToken] = DispatchObject<T>(type: type, dispatchSbj: dispatchSbj, dispatchSbjErr: dispatchSbjErr)
        return nextDispatchToken
    }
    
    public func unregister(_ dispatchToken: DispatchToken) {
        dispatchObjs.removeValue(forKey: dispatchToken)
    }
    
    public func dispatchSbj<T: Action>(type: T.Type, dispatchToken: DispatchToken) -> AnyObject? {
        guard let dispatchObj = dispatchObjs[dispatchToken] as? DispatchObject<T> else { return nil}
        return dispatchObj.dispatchSbj
    }
    
    public func dispatchSbjErr<T: Action>(type: T.Type, dispatchToken: DispatchToken) -> AnyObject? {
        guard let dispatchObj = dispatchObjs[dispatchToken] as? DispatchObject<T> else { return nil}
        return dispatchObj.dispatchSbjErr
    }
    
}

private class DispatchObject<T: Action> {
    let type: T.Type
    let dispatchSbj: DispatchSubject<T.Payload>
    let dispatchSbjErr: DispatchSubject<T.ErrorType>
    
    init(type: T.Type, dispatchSbj: DispatchSubject<T.Payload>, dispatchSbjErr: DispatchSubject<T.ErrorType>) {
        self.type = type
        self.dispatchSbj = dispatchSbj
        self.dispatchSbjErr = dispatchSbjErr
    }
}
