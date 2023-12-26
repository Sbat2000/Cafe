//
//  MapModuleBuilder.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

import UIKit

class MapModuleBuilder {
    static func build() -> MapViewController {
        let interactor = MapInteractor()
        let router = MapRouter()
        let presenter = MapPresenter(interactor: interactor, router: router)
        let viewController = MapViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
