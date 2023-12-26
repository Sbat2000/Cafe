//
//  MapInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

import CoreLocation

protocol MapInteractorProtocol: AnyObject {
    func getCurrentLocation() -> CLLocation?
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol?
    
    private let locationManager: LocationManagerProtocol
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }
    
    func getCurrentLocation() -> CLLocation? {
        locationManager.currentLocation
    }
}
