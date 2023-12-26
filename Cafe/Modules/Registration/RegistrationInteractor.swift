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
    private var authService: AuthServiceProtocol
    private var tokenStorage: TokenStorageProtocol
    
    init(authService: AuthServiceProtocol, tokenStorage: TokenStorageProtocol) {
        self.authService = authService
        self.tokenStorage = tokenStorage
    }
    
    func register(user: UserModel) {
        authService.register(user: user) { [weak self] result in
            switch result {
            case .success(let token):
                self?.tokenStorage.saveToken(token.token)
                self?.presenter?.registrationSuccess()
            case .failure(let error):
                print("Ошибка регистрации: \(error.localizedDescription)")
                self?.presenter?.loginFailedWithError(error)
            }
        }
    }
}
