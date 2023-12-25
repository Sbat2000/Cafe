//
//  OrderInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

import Foundation

protocol OrderInteractorProtocol: AnyObject {
    func getTotalQuantity() -> Int
    func getOrderItem(at indexPath: IndexPath) -> OrderItem?
    func addMenuItem(_ menuItem: MenuItem, quantity: Int)
}

class OrderInteractor: OrderInteractorProtocol {
    weak var presenter: OrderPresenterProtocol?
    
    private let orderService: OrderServiceProtocol
    
    init(orderService: OrderServiceProtocol) {
        self.orderService = orderService
    }
    
    func getTotalQuantity() -> Int {
        orderService.getTotalQuantity()
    }
    
    func getOrderItem(at indexPath: IndexPath) -> OrderItem? {
        guard indexPath.row < orderService.getCurrentOrder().count else {
            return nil
        }
        return orderService.getOrderItem(at: indexPath)
    }
    
    func addMenuItem(_ menuItem: MenuItem, quantity: Int) {
        orderService.addMenuItem(menuItem, quantity: quantity)
    }
}
