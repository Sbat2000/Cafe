//
//  LocationManager.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import CoreLocation

protocol LocationManagerProtocol {
    var currentLocation: CLLocation? { get }
    func requestLocation()
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {
    private let locationManager = CLLocationManager()
    private(set) var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка при получении местоположения: \(error)")
    }
}
