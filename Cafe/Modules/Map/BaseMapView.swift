//
//  BaseMapView.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 26.12.2023.
//

fileprivate struct ApiKey {
    #warning("press api here:")
    static let apiKey = "731efe8b-382b-4030-8010-a2ccad248156"
}

import UIKit
import YandexMapsMobile

class BaseMapView: UIView {
    
    // MARK: - Public properties
    
    @objc public var mapView: YMKMapView!

    // MARK: - LifeCycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        YMKMapKit.setApiKey("\(ApiKey.apiKey)")
        YMKMapKit.sharedInstance().onStart()
        setup()
    }

    // MARK: - Methods
    
    private func setup() {
        // OpenGl is deprecated under M1 simulator, we should use Vulkan
        mapView = YMKMapView(frame: bounds, vulkanPreferred: BaseMapView.isM1Simulator())
        mapView.mapWindow.map.mapType = .map
    }

    static func isM1Simulator() -> Bool {
        return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
    }
}
