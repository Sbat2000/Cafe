//
//  MenuItem.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

struct MenuItem: Decodable, Hashable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Double
}
