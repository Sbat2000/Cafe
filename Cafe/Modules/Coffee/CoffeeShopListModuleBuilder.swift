//
//  CoffeeShopListModuleBuilder.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import UIKit

class CoffeeShopListModuleBuilder {
    static func build() -> UIViewController {
        let interactor = CoffeeShopListInteractor()
        let router = CoffeeShopListRouter()
        let presenter = CoffeeShopListPresenter(interactor: interactor, router: router)
        let viewController = CoffeeShopListViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
}
