//
//  SubcriberRequest.swift
//  RxSwiftFluxDemo
//
//  Created by DUONG VANHOP on 2017/07/07.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import APIUtility
import RxAlamofire
import Alamofire

struct SubcriberRequest: APIRequest {
    typealias Response = SubcriberResponse
    let method: Alamofire.HTTPMethod = .get
    let path: String = "/search?"
    var parameters: [String : Any]? = ["term": "beatles",
                                      "country": "JP",
                                      "lang": "ja_jp",
                                      "media": "music"]

}
