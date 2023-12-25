//
//  MenuRouter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

protocol MenuRouterProtocol {
    func navigateToOrder()
}

class MenuRouter: MenuRouterProtocol {
    weak var viewController: MenuViewController?
    
    func navigateToOrder() {
        let orderViewController = OrderModuleBuilder.build()
        viewController?.navigationController?.pushViewController(orderViewController, animated: true)
    }
}
