//
//  AuthToken.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 24.12.2023.
//

import Foundation

struct AuthToken: Codable {
    let token: String
    let tokenLifetime: Int
}
