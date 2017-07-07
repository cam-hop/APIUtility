//
//  DispatchSubject.swift
//  RxSwiftFlux
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import RxSwift
import RxCocoa

public class DispatchSubject<Element>: ObservableType, ObserverType {
    public typealias E = Element
    private let subject = PublishSubject<Element>()
    
    public init() {}
    
    public func dispatch(_ value: Element) {
        on(.next(value))
    }
    
    public func subscribe<O: ObserverType>(_ obsever: O) -> Disposable where O.E == E {
        return subject.subscribe(obsever)
    }
    
    public func on(_ event: Event<E>) {
        subject.on(event)
    }
}
