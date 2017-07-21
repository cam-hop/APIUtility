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
    associatedtype Error
    var baseURL: String { get }
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var parameters: [String : Any]? { get }
    var headerFields: [String : String] { get }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response
    func errorResponse(form object: Any, urlResponse: HTTPURLResponse) throws -> Self.Error
}

public extension APIRequest where Response: Decodable {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response.decodeValue(object)
    }
}

public extension APIRequest where Error: Decodable {
    public func errorResponse(from object: Any, urlResponse: HTTPURLResponse) throws -> Error {
        return try Error.decodeValue(object)
    }
}

public enum ResponseHeader: Int {
    case active
    case forceUpdate
    case maintenance
}
