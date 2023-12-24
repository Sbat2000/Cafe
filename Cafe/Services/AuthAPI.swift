//
//  AuthAPI.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 24.12.2023.
//

import Moya
import Foundation

enum AuthAPI {
    case register(login: String, password: String)
    case login(login: String, password: String)
}

extension AuthAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "http://147.78.66.203:3210")!
    }
    
    var path: String {
        switch self {
        case .register:
            "/auth/register"
        case .login:
            "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register:
                .post
        case .login:
                .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .register(let login, let password):
                .requestParameters(parameters: ["login": login, "password": password], encoding: JSONEncoding.default)
        case .login(let login, let password):
                .requestParameters(parameters: ["login": login, "password": password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
