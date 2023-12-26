//
//  LoginRouter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import UIKit

protocol LoginRouterProtocol {
    func navigateToCoffeShopList()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewController?
    
    func navigateToCoffeShopList() {
        let coffeeShopsListViewController = CoffeeShopListModuleBuilder.build()
        if let window = viewController?.view.window, let navController = window.rootViewController as? UINavigationController {            navController.setViewControllers([coffeeShopsListViewController], animated: true)
        }
    }
}
