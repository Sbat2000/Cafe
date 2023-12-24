//
//  RegistrationModuleBuilder.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

import UIKit

class RegistrationModuleBuilder {
    static func build() -> UIViewController {
        let interactor = RegistrationInteractor(authService: AppDependencies.shared.authService)
        let router = RegistrationRouter()
        let presenter = RegistrationPresenter(interactor: interactor, router: router)
        let viewController = RegistrationViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
}
