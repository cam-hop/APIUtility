//
//  NSObjectProtocolExtension.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        let className = NSStringFromClass(self)
        let range = className.range(of: ".")
        return className.substring(from: range!.upperBound)
    }
}
