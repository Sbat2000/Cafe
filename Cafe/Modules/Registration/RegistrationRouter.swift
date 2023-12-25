//
//  RegistrationRouter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

import UIKit

protocol RegistrationRouterProtocol {
    func navigateToLogin()
    func navigateToCoffeShopList()
}

class RegistrationRouter: RegistrationRouterProtocol {
    weak var viewController: RegistrationViewController?
    
    func navigateToLogin() {
        let loginViewController = LoginModuleBuilder.build()
        viewController?.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func navigateToCoffeShopList() {
        let coffeeShopsListViewController = CoffeeShopListModuleBuilder.build()
        if let window = viewController?.view.window, let navController = window.rootViewController as? UINavigationController {            navController.setViewControllers([coffeeShopsListViewController], animated: true)
        }
    }
}
