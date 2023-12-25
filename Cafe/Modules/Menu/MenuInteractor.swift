//
//  MenuInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

protocol MenuInteractorProtocol: AnyObject {
    func fetchMenuItems()
    func addMenuItem(_ menuItem: MenuItem, quantity: Int)
    func getOrderItem(for menuItem: MenuItem) -> OrderItem?
    func clearOrder()
}

class MenuInteractor: MenuInteractorProtocol {
    weak var presenter: MenuPresenterProtocol?
    
    private let cafeId: Int
    private let tokenStorage: TokenStorageProtocol
    private let menuService: MenuServiceProtocol
    private let orderService: OrderServiceProtocol
    
    init(cafeId: Int, tokenStorage: TokenStorageProtocol, menuService: MenuServiceProtocol, orderService: OrderServiceProtocol) {
        self.cafeId = cafeId
        self.tokenStorage = tokenStorage
        self.menuService = menuService
        self.orderService = orderService
        fetchMenuItems()
    }
    
    func fetchMenuItems() {
        guard let token = tokenStorage.getToken() else {
            presenter?.didFailToFetchMenuItems(with: MenuRequestError.unauthorized)
            return
        }
        
        menuService.getMenu(token: token, cafeId: cafeId) { [weak self] result in
            switch result {
            case .success(let menuItems):
                self?.presenter?.didFetchMenuItems(menuItems)
            case .failure(let error):
                self?.presenter?.didFailToFetchMenuItems(with: error)
            }
        }
    }
    
    func addMenuItem(_ menuItem: MenuItem, quantity: Int) {
        orderService.addMenuItem(menuItem, quantity: quantity)
    }
    
    func clearOrder() {
        orderService.clearOrder()
    }
    
    func getOrderItem(for menuItem: MenuItem) -> OrderItem? {
        orderService.getOrderItem(for: menuItem)
    }
}
