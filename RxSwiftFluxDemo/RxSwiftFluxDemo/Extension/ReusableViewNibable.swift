//
//  ReusableViewNibable.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import UIKit

protocol ReusableViewNibable: Nibable {
    static var identifier: String { get }
}

extension ReusableViewNibable {
    static var identifier: String {
        return className
    }
}

extension UITableViewHeaderFooterView: ReusableViewNibable {}
