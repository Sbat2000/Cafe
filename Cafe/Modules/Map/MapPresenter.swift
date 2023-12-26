//
//  MapPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

import CoreLocation

protocol MapPresenterProtocol: AnyObject {
    func mapViewControllerDidLoad()
    func getCurrentLocation() -> CLLocation?
}

class MapPresenter {
    weak var view: MapViewProtocol?
    var router: MapRouterProtocol
    var interactor: MapInteractorProtocol
    private var coffee: [CoffeeShopViewModel]

    init(interactor: MapInteractorProtocol, router: MapRouterProtocol, coffee: [CoffeeShopViewModel]) {
        self.interactor = interactor
        self.router = router
        self.coffee = coffee
    }
}

extension MapPresenter: MapPresenterProtocol {
    
    func mapViewControllerDidLoad() {
        view?.displayCoffeeShops(coffee)
        view?.showUserLocation()
    }
    
    func getCurrentLocation() -> CLLocation? {
        interactor.getCurrentLocation()
    }
}
