//
//  CoffeeShop.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import Foundation

struct CoffeeShop: Codable {
    let id: Int
    let name: String
    let point: LocationPoint
}

struct LocationPoint: Codable {
    let latitude: String
    let longitude: String
}
