//
//  MapViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

import UIKit
import YandexMapsMobile

protocol MapViewProtocol: AnyObject {
}

class MapViewController: UIViewController {
    
    private var mapView: YMKMapView = BaseMapView().mapView
    
    // MARK: - Public
    var presenter: MapPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension MapViewController {
    func initialize() {
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.addSubview(mapView)
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - MapViewProtocol
extension MapViewController: MapViewProtocol {
}
