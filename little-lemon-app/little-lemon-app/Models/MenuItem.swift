//
//  MenuItem.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
    let image: String
    let explanation: String
    let category: String
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case price = "price"
        case explanation = "description"
        case category = "category"
    }
}
