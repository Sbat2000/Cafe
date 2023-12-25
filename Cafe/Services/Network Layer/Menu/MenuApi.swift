//
//  MenuApi.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import Moya
import Foundation

enum MenuAPI {
    case getMenu(token: String, id: Int)
}

extension MenuAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "http://147.78.66.203:3210")!
    }
    
    var path: String {
        switch self {
        case .getMenu(_, let id):
            "/location/\(id)/menu"
        }
     }
    
    var method: Moya.Method {
        switch self {
        case .getMenu:
                .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMenu:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMenu(let token, _):
            ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
        }
    }
}


