//
//  MapViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

import UIKit
import YandexMapsMobile

protocol MapViewProtocol: AnyObject {
    func showUserLocation()
    func displayCoffeeShops(_ coffeeShops: [CoffeeShopViewModel]) 
}

class MapViewController: UIViewController {
    
    private var mapView: YMKMapView = BaseMapView().mapView
    
    // MARK: - Public
    var presenter: MapPresenterProtocol?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.mapViewControllerDidLoad()
    }
}

// MARK: - Private functions
private extension MapViewController {
    func initialize() {
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - MapViewProtocol
extension MapViewController: MapViewProtocol {
    func showUserLocation() {
        guard let location = presenter?.getCurrentLocation() else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        
        let placemark = mapObjects.addPlacemark(with: YMKPoint(latitude: latitude, longitude: longitude))
        placemark.setIconWith(UIImage(systemName: "person.fill")!)
        
        let cameraPosition = YMKCameraPosition(target: YMKPoint(latitude: latitude, longitude: longitude), zoom: 14, azimuth: 0, tilt: 0)
        mapView.mapWindow.map.move(with: cameraPosition)
    }
    
    func displayCoffeeShops(_ coffeeShops: [CoffeeShopViewModel]) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()

        for coffeeShop in coffeeShops {
            if let latitude = Double(coffeeShop.point.latitude), let longitude = Double(coffeeShop.point.longitude) {
                let point = YMKPoint(latitude: latitude, longitude: longitude)
                let placemark = mapObjects.addPlacemark(with: point)
                placemark.setIconWith(UIImage(resource: .cooffee))
            } else {
                print("Ошибка: Невозможно преобразовать координаты в Double")
            }
        }
    }
}
