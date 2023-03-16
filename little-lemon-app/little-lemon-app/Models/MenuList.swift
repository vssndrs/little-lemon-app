//
//  MenuList.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import Foundation

struct MenuList: Decodable {
    let menu: [MenuItem]
    enum CodingKeys: String, CodingKey {
            case menu = "menu"
        }
}
