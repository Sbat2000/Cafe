//
//  LoginInteractor.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

protocol LoginInteractorProtocol: AnyObject {
    func login(user: UserModel)
}

class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol?
    
    var authService: AuthServiceProtocol
    private var tokenStorage: TokenStorageProtocol
    
    init(authService: AuthServiceProtocol, tokenStorage: TokenStorageProtocol) {
        self.authService = authService
        self.tokenStorage = tokenStorage
    }
    
    func login(user: UserModel) {
        authService.login(user: user) { [weak self] result in
            switch result {
            case .success(let token):
                print("Получен token: \(token)")
                self?.tokenStorage.saveToken(token.token)
                self?.presenter?.loginSucceeded()
            case .failure(let error):
                print("Ошибка получения токена: \(error.localizedDescription)")
            }
        }
    }
}
