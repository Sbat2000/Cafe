//
//  RegistrationPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

protocol RegistrationPresenterProtocol: AnyObject {
}

class RegistrationPresenter {
    weak var view: RegistrationViewProtocol?
    var router: RegistrationRouterProtocol
    var interactor: RegistrationInteractorProtocol

    init(interactor: RegistrationInteractorProtocol, router: RegistrationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension RegistrationPresenter: RegistrationPresenterProtocol {
}
