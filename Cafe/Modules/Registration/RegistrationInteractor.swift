//
//  RegistrationInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

protocol RegistrationInteractorProtocol: AnyObject {
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    weak var presenter: RegistrationPresenterProtocol?
}
