//
//  API.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import APIUtility

extension APIRequest {
    var baseURL: String {
        return "https://itunes.apple.com"
    }

    var headerFields: [String : String] {
        return ["": ""]
    }
}
