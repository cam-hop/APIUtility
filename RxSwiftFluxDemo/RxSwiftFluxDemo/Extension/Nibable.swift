//
//  Nibable.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import UIKit

protocol Nibable: NSObjectProtocol {
    associatedtype Instance
    static func makeFromNib(_ index: Int) -> Instance
    static var nib: UINib { get }
    static var nibName: String { get }
}

extension Nibable {
    static var nibName: String {
        return className
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }

    static func makeFromNib(_ index: Int = 0) -> Self {
        return nib.instantiate(withOwner: self, options: nil)[index] as! Self
    }
}

extension NSObject {

    class var className: String {

        return String(describing: self)
    }

    var className: String {

        return type(of: self).className
    }
}

