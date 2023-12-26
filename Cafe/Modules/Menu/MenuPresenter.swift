//
//  MenuPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

import Foundation

protocol MenuPresenterProtocol: MenuItemCellDelegate,  AnyObject {
    func didFetchMenuItems(_ items: [MenuItem])
    func didFailToFetchMenuItems(with error: Error)
    func getMenuItems(at indexPath: IndexPath) -> MenuItem
    func getOrderItem(for menuItem: MenuItem) -> OrderItem?
    func getMenuItemsCount() -> Int
    func menuViewControllerDeinit()
    func goToPayButtonTapped()
}

class MenuPresenter {
    weak var view: MenuViewProtocol?
    var router: MenuRouterProtocol
    var interactor: MenuInteractorProtocol
    
    private var menuItems: [MenuItem] = []
    private var menuItemsOrder: [MenuItem : Int] = [:]
    
    init(interactor: MenuInteractorProtocol, router: MenuRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MenuPresenter: MenuPresenterProtocol {
    func didFetchMenuItems(_ items: [MenuItem]) {
        self.menuItems = items
        view?.updateMenu()
    }
    
    func didFailToFetchMenuItems(with error: Error) {
        
    }
    
    func getMenuItems(at indexPath: IndexPath) -> MenuItem {
        menuItems[indexPath.row]
    }
    
    func getMenuItemsCount() -> Int {
        menuItems.count
    }
    
    func menuViewControllerDeinit() {
        interactor.clearOrder()
    }
    
    func goToPayButtonTapped() {
        router.navigateToOrder()
    }
    
    func getOrderItem(for menuItem: MenuItem) -> OrderItem? {
        interactor.getOrderItem(for: menuItem)
    }
}

extension MenuPresenter: MenuItemCellDelegate {
    func menuItemCell(didUpdateQuantity quantity: Int, forItem menuItem: MenuItem) {
        interactor.addMenuItem(menuItem, quantity: quantity)
    }
}
