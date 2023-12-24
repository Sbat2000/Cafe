//
//  CoffeeShopListPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

protocol CoffeeShopListPresenterProtocol: AnyObject {
    func onMapButtonTapped()
}

class CoffeeShopListPresenter {
    weak var view: CoffeeShopListViewProtocol?
    var router: CoffeeShopListRouterProtocol
    var interactor: CoffeeShopListInteractorProtocol

    init(interactor: CoffeeShopListInteractorProtocol, router: CoffeeShopListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CoffeeShopListPresenter: CoffeeShopListPresenterProtocol {
    func onMapButtonTapped() {
        
    }
}
