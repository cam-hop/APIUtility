//
//  Store.swift
//  RxSwiftFlux
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import RxSwift
import RxCocoa

public struct StoreVariable<Base> {
    let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol StoreVariableCompatible {
    associatedtype CompatibleType
    
    var sv: StoreVariable<CompatibleType> { get set }
}

public extension StoreVariableCompatible {
    var sv: StoreVariable<Self> {
        get {
            return StoreVariable(self)
        }
        set {
            // this enables using AnyVariable to "mutate" base object
        }
    }
}

open class Store: ReactiveCompatible, StoreVariableCompatible {
    
    let disposeBag = DisposeBag()
    
    func bind<O, E>(_ observable: O, _ param: Variable<E>) where O: ObservableType, E == O.E {
        observable.bind(to: param).addDisposableTo(disposeBag)
    }
    
    func bind<O, E>(_ observable: O, _ param: PublishSubject<E>) where O: ObservableType, E == O.E {
        observable.bind(to: param).addDisposableTo(disposeBag)
    }
}
