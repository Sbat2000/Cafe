//
//  RegistrationPresenter.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func checkRegistrationAvailability()
    func registrationButtonTapped()
    func loginButtonTapped()
    func registrationSuccess()
}

class RegistrationPresenter {
    weak var view: RegistrationViewProtocol?
    var router: RegistrationRouterProtocol
    var interactor: RegistrationInteractorProtocol
    
    init(interactor: RegistrationInteractorProtocol, router: RegistrationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension RegistrationPresenter: RegistrationPresenterProtocol {
    func checkRegistrationAvailability() {
        guard let email = view?.getEmail(),
              let password = view?.getPassword(),
              let confirmPassword = view?.getConfirmPassword()
        else {
            view?.setRegistrationButtonEnabled(false)
            return
        }
        let isEmailValid = isValidEmail(email)
        let arePasswordsEqual = !password.isEmpty && password == confirmPassword
        let isButtonEnabled = isEmailValid && arePasswordsEqual
        view?.setRegistrationButtonEnabled(isButtonEnabled)
    }
    
    func registrationButtonTapped() {
        guard let email = view?.getEmail(),
              let password = view?.getPassword() else { return }
        let user = UserModel(login: email, password: password)
        interactor.register(user: user)
    }
    
    func loginButtonTapped() {
        router.navigateToLogin()
    }
    
    func registrationSuccess() {
        router.navigateToCoffeShopList()
    }
}
