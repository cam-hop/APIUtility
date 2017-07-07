//
//  UIImageViewExtension.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    /// Set image by Kingfisher
    ///
    /// - Parameter url: type of the event
    public func setImageKf(with url: URL) {

        self.kf.setImage(with: url,
                         placeholder: UIImage(named: "noimage"),
                         options: nil,
                         progressBlock: { receivedSize, totalSize in
                            print("\(receivedSize)/\(totalSize)")},
                         completionHandler: { _, error, cacheType, _ in
                            print(cacheType)
                            if let `error` = error {
                                print(error.localizedDescription)
                            }
        })
    }
    
}
