//
//  CoffeeShopListPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import Foundation

protocol CoffeeShopListPresenterProtocol: AnyObject {
    func onMapButtonTapped()
    func didRetrieveCoffeeShops(_ coffeeShops: [CoffeeShopViewModel])
    func didFailToRetrieveCoffeeShops(error: Error)
    func refreshCoffeeShops()
    func getCoffeesCount() -> Int
    func getCoffeeShop(at indexPath: IndexPath) -> CoffeeShopViewModel
    func didSelectCoffeeShop(with coffeeShopId: Int)
}

class CoffeeShopListPresenter {
    weak var view: CoffeeShopListViewProtocol?
    var router: CoffeeShopListRouterProtocol
    var interactor: CoffeeShopListInteractorProtocol
    private var coffeeShops: [CoffeeShopViewModel] = []
    
    init(interactor: CoffeeShopListInteractorProtocol, router: CoffeeShopListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CoffeeShopListPresenter: CoffeeShopListPresenterProtocol {
    func onMapButtonTapped() {
        router.navigateToMap()
    }
    
    func refreshCoffeeShops() {
        interactor.retrieveCoffeeShops()
    }
    
    func didRetrieveCoffeeShops(_ coffeeShops: [CoffeeShopViewModel]) {
        self.coffeeShops = coffeeShops
        view?.updateCoffeeTableView()
    }
    
    func didFailToRetrieveCoffeeShops(error: Error) {
        if let coffeeError = error as? CoffeeRequestError, coffeeError == .unauthorized {
            print("Ошибка авторизации: \(coffeeError)")
            router.navigateToRegistration()
        }
    }
    
    func getCoffeesCount() -> Int {
        coffeeShops.count
    }
    
    func getCoffeeShop(at indexPath: IndexPath) -> CoffeeShopViewModel {
        coffeeShops[indexPath.row]
    }
    
    func didSelectCoffeeShop(with coffeeShopId: Int) {
        router.navigateToMenu(with: coffeeShopId)
    }
}
