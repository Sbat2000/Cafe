//
//  RegistrationRouter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

protocol RegistrationRouterProtocol {
    func navigateToLogin()
}

class RegistrationRouter: RegistrationRouterProtocol {
    weak var viewController: RegistrationViewController?
    
    func navigateToLogin() {
        let loginViewController = LoginModuleBuilder.build()
        viewController?.navigationController?.pushViewController(loginViewController, animated: true)
    }
}
