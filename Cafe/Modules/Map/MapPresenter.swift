//
//  MapPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

protocol MapPresenterProtocol: AnyObject {
}

class MapPresenter {
    weak var view: MapViewProtocol?
    var router: MapRouterProtocol
    var interactor: MapInteractorProtocol

    init(interactor: MapInteractorProtocol, router: MapRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MapPresenter: MapPresenterProtocol {
}
