//
//  MenuItem.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import Foundation

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
    let image: String
} 
