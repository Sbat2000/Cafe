//
//  MapInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 26.12.2023
//

protocol MapInteractorProtocol: AnyObject {
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol?
}
