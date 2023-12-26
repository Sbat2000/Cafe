//
//  OrderModuleBuilder.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

import UIKit

class OrderModuleBuilder {
    static func build() -> OrderViewController {
        let interactor = OrderInteractor(orderService: AppDependencies.shared.orderService)
        let router = OrderRouter()
        let presenter = OrderPresenter(interactor: interactor, router: router)
        let viewController = OrderViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
