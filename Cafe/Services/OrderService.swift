//
//  OrderService.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import Foundation

protocol OrderServiceProtocol {
    func addMenuItem(_ menuItem: MenuItem, quantity: Int)
    func removeMenuItem(_ menuItem: MenuItem)
    func getCurrentOrder() -> [OrderItem]
    func clearOrder()
    func getTotalQuantity() -> Int
    func getOrderItem(at indexPath: IndexPath) -> OrderItem
    func getOrderItem(for menuItem: MenuItem) -> OrderItem?
}

class OrderService: OrderServiceProtocol {

    private var orderItems: [OrderItem] = []

    func addMenuItem(_ menuItem: MenuItem, quantity: Int) {
        if quantity == 0 {
            orderItems.removeAll { $0.menuItem == menuItem }
        } else {
            if let index = orderItems.firstIndex(where: { $0.menuItem == menuItem }) {
                orderItems[index].quantity = quantity
            } else {
                orderItems.append(OrderItem(menuItem: menuItem, quantity: quantity))
            }
        }
    }

    func removeMenuItem(_ menuItem: MenuItem) {
        orderItems.removeAll { $0.menuItem == menuItem }
    }
    
    func getCurrentOrder() -> [OrderItem] {
        orderItems
    }


    func clearOrder() {
        orderItems.removeAll()
    }

    func getTotalQuantity() -> Int {
        orderItems.count
    }
    
    func getOrderItem(at indexPath: IndexPath) -> OrderItem {
        return orderItems[indexPath.row]
    }
    
    func getOrderItem(for menuItem: MenuItem) -> OrderItem? {
            return orderItems.first { $0.menuItem == menuItem }
        }
}
