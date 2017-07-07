//
//  CellNibable.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import UIKit

protocol CellNibable: Nibable {
    static var identifier: String { get }
}

extension CellNibable {
    static var identifier: String {
        return className
    }
}

extension UITableViewCell: CellNibable {}
extension UICollectionReusableView: CellNibable {}
