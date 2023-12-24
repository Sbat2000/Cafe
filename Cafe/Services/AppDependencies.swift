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
    let tokenStorage: TokenStorageProtocol
    
    private init() {
        authService = AuthService()
        tokenStorage = TokenStorage()
    }
}
