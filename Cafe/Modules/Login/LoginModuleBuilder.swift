//
//  LoginModuleBuilder.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import UIKit

class LoginModuleBuilder {
    static func build() -> LoginViewController {
        let interactor = LoginInteractor(authService: AppDependencies.shared.authService, tokenStorage: AppDependencies.shared.tokenStorage)
        let router = LoginRouter()
        let presenter = LoginPresenter(interactor: interactor, router: router)
        let viewController = LoginViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
