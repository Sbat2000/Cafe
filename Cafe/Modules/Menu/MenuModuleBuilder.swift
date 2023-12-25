//
//  MenuModuleBuilder.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

import UIKit

class MenuModuleBuilder {
    static func build(with cafeId: Int) -> MenuViewController {
        let interactor = MenuInteractor(cafeId: cafeId, tokenStorage: AppDependencies.shared.tokenStorage, menuService: AppDependencies.shared.menuService, orderService: AppDependencies.shared.orderService)
        let router = MenuRouter()
        let presenter = MenuPresenter(interactor: interactor, router: router)
        let viewController = MenuViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
