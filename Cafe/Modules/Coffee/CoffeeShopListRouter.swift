//
//  CoffeeShopListRouter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import UIKit

protocol CoffeeShopListRouterProtocol {
    func navigateToRegistration()
    func navigateToMenu(with coffeeShopId: Int)
}

class CoffeeShopListRouter: CoffeeShopListRouterProtocol {
    weak var viewController: CoffeeShopListViewController?
    
    func navigateToRegistration() {
        let registrationViewController = RegistrationModuleBuilder.build()
        if let window = viewController?.view.window, let navController = window.rootViewController as? UINavigationController {            navController.setViewControllers([registrationViewController], animated: true)
        }
    }
    
    func navigateToMenu(with coffeeShopId: Int) {
        let menuViewController = MenuModuleBuilder.build(with: coffeeShopId)
        if let window = viewController?.view.window, let navController = window.rootViewController as? UINavigationController {            navController.pushViewController(menuViewController, animated: true)
        }
    }
}
