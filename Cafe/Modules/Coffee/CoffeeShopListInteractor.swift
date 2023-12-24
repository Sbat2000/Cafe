//
//  CoffeeShopListInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

protocol CoffeeShopListInteractorProtocol: AnyObject {
}

class CoffeeShopListInteractor: CoffeeShopListInteractorProtocol {
    weak var presenter: CoffeeShopListPresenterProtocol?
}
