//
//  LoginPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//
import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func loginButtonTapped()
    func checkLoginAvailability()
    func loginSucceeded()
    func registrationFailedWithError(_ error: Error)
}

class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol
    var interactor: LoginInteractorProtocol

    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func loginButtonTapped() {
        guard let email = view?.getEmail(),
              let password = view?.getPassword() else { return }
        let user = UserModel(login: email, password: password)
        interactor.login(user: user)
    }
    
    func checkLoginAvailability() {
        guard let email = view?.getEmail(),
              let password = view?.getPassword()
        else {
            view?.setLoginButtonEnabled(false)
            return
        }
        let isEmailValid = isValidEmail(email)
        let isButtonEnabled = isEmailValid && !password.isEmpty
        view?.setLoginButtonEnabled(isButtonEnabled)
    }
    
    func loginSucceeded() {
        router.navigateToCoffeShopList()
    }
    
    func registrationFailedWithError(_ error: Error) {
        view?.showErrorAlert(with: error.localizedDescription)
    }
}
