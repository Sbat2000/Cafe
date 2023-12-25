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
    let coffeeService: CoffeeServiceProtocol
    let tokenStorage: TokenStorageProtocol
    let locationManager: LocationManagerProtocol
    let menuService: MenuServiceProtocol
    let orderService: OrderServiceProtocol
    
    private init() {
        authService = AuthService()
        tokenStorage = TokenStorage()
        coffeeService = CoffeeService()
        locationManager = LocationManager()
        menuService = MenuService()
        orderService = OrderService()
    }
}
