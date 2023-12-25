//
//  CoffeeAPI.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import Moya
import Foundation

enum CoffeeAPI {
    case getCoffeeShops(token: String)
}

extension CoffeeAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "http://147.78.66.203:3210")!
    }
    
    var path: String {
        switch self {
        case .getCoffeeShops:
            "/locations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCoffeeShops:
                .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCoffeeShops:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCoffeeShops(let token):
            ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
        }
    }
}

