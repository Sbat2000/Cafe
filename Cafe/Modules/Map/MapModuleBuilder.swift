//
//  MapModuleBuilder.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

import UIKit

class MapModuleBuilder {
    static func build(coffee: [CoffeeShopViewModel]) -> MapViewController {
        let interactor = MapInteractor(locationManager: AppDependencies.shared.locationManager)
        let router = MapRouter()
        let presenter = MapPresenter(interactor: interactor, router: router, coffee: coffee)
        let viewController = MapViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
