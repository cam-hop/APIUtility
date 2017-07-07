//
//  ApiRequest.swift
//  APIUtility
//
//  Created by DUONG VANHOP on 2017/07/07.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import Alamofire
import Himotoki

public protocol APIRequest {
    associatedtype Response
    var baseURL: String { get }
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var parameters: [String : Any]? { get }
    var headerFields: [String : String] { get }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response
}

public extension APIRequest where Response: Decodable {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response.decodeValue(object)
    }
}
