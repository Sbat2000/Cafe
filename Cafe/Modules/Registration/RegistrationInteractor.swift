//
//  RegistrationInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

protocol RegistrationInteractorProtocol: AnyObject {
    func register(user: UserModel)
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    weak var presenter: RegistrationPresenterProtocol?
    var authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func register(user: UserModel) {
        authService.register(user: user) { [weak self] result in
            switch result {
            case .success(let token):
                print("Регистрация успешна!, token: \(token)")
            case .failure(let error):
                print("Ошибка регистрации: \(error.localizedDescription)")
            }
        }
    }
}
