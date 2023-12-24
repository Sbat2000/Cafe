//
//  DependencyContainer.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 24.12.2023.
//

import Foundation

final class AppDependencies {
    static let shared = AppDependencies()
    
    let authService: AuthServiceProtocol
    
    private init() {
        authService = AuthService()
    }
}
