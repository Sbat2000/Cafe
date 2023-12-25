//
//  OrderPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

import Foundation

protocol OrderPresenterProtocol: OrderTableViewCellDelegate, AnyObject {
    func getTotalQuantity() -> Int
    func fetchOrderItem(at indexPath: IndexPath) -> OrderItem?
    
}

class OrderPresenter {
    weak var view: OrderViewProtocol?
    var router: OrderRouterProtocol
    var interactor: OrderInteractorProtocol

    init(interactor: OrderInteractorProtocol, router: OrderRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension OrderPresenter: OrderPresenterProtocol {
    func menuItemCell(didUpdateQuantity quantity: Int, forItem menuItem: MenuItem) {
        interactor.addMenuItem(menuItem, quantity: quantity)
    }
    
    func getTotalQuantity() -> Int {
        interactor.getTotalQuantity()
    }
    
    func fetchOrderItem(at indexPath: IndexPath) -> OrderItem? {
        guard let orderItem = interactor.getOrderItem(at: indexPath) else { return nil }
        return orderItem
    }
}

