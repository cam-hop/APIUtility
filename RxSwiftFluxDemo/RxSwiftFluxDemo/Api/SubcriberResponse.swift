//
//  SubcriberResponse.swift
//  RxSwiftFluxDemo
//
//  Created by DUONG VANHOP on 2017/07/07.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import Himotoki

struct SubcriberResponse : Decodable {
    let resultCount: Int
    let results: [Subcriber]?

    static func decode(_ e: Extractor) throws -> SubcriberResponse {
        return try SubcriberResponse(
            resultCount: e <| "resultCount",
            results: e <||? "results"
        )
    }
}
