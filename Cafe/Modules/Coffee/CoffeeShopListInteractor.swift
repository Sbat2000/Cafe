//
//  CoffeeShopListInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import CoreLocation

protocol CoffeeShopListInteractorProtocol: AnyObject {
    func retrieveCoffeeShops()
}

class CoffeeShopListInteractor: CoffeeShopListInteractorProtocol {
    weak var presenter: CoffeeShopListPresenterProtocol?
    
    private let coffeeService: CoffeeServiceProtocol
    private let tokenStorage: TokenStorageProtocol
    private let locationManager: LocationManagerProtocol
    
    init(coffeeService: CoffeeServiceProtocol, tokenStorage: TokenStorageProtocol, locationManager: LocationManagerProtocol) {
        self.coffeeService = coffeeService
        self.tokenStorage = tokenStorage
        self.locationManager = locationManager
    }
    
    func retrieveCoffeeShops() {
        guard let token = tokenStorage.getToken() else {
            return
        }
        
        locationManager.requestLocation()
        
        coffeeService.getCoffeeShops(token: token) { [weak self] result in
            switch result {
            case .success(let coffeeShops):
                let currentLocation = self?.locationManager.currentLocation
                let processedShops = self?.processCoffeeShops(coffeeShops, currentLocation: currentLocation)
                self?.presenter?.didRetrieveCoffeeShops(processedShops ?? [])
            case .failure(let error):
                self?.presenter?.didFailToRetrieveCoffeeShops(error: error)
            }
        }
    }
    
    private func processCoffeeShops(_ coffeeShops: [CoffeeShop], currentLocation: CLLocation?) -> [CoffeeShopViewModel] {
        return coffeeShops.map { shop in
            let shopLocation = CLLocation(latitude: Double(shop.point.latitude) ?? 0.0, longitude: Double(shop.point.longitude) ?? 0.0)
            let distance: String
            if let currentLocation = currentLocation {
                        let distanceInMeters = currentLocation.distance(from: shopLocation)
                        if distanceInMeters < 1000 {
                            distance = String(format: "%.0f м", distanceInMeters)
                        } else {
                            distance = String(format: "%.0f км", distanceInMeters / 1000)
                        }
                    } else {
                        distance = "Ваша локация не определена"
                    }
            return CoffeeShopViewModel(name: shop.name, distance: distance, id: shop.id, point: shop.point)
        }
    }
}
