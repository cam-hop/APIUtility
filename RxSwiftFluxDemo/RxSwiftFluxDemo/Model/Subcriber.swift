//
//  SubcriberModel.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import Himotoki

struct Subcriber: Decodable {
    let name: String
    let generation: String
    let imageUrl: String

    static func decode(_ e: Extractor) throws -> Subcriber {
        return try Subcriber(
            name: e <| "trackName",
            generation: e <| "artistName",
            imageUrl: e <| "artworkUrl100"
        )
    }
}
