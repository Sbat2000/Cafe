//
//  AuthService.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 24.12.2023.
//

enum RegistrationError: Error {
    case httpStatusCode(Int)
}

import Foundation
import Moya
import ProgressHUD

protocol AuthServiceProtocol {
    func register(user: UserModel, completion: @escaping (Result<AuthToken, Error>) -> Void)
    func login(user: UserModel, completion: @escaping (Result<AuthToken, Error>) -> Void)
}

final class AuthService: AuthServiceProtocol {
    let provider = MoyaProvider<AuthAPI>()
    
    func register(user: UserModel, completion: @escaping (Result<AuthToken, Error>) -> Void) {
        UIBlockingProgressHUD.show()
        provider.request(.register(login: user.login, password: user.password)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 406 {
                    print("Ошибка регистрации: Возможно такой аккаунт уже есть \(RegistrationError.httpStatusCode(response.statusCode))")
                    completion(.failure(RegistrationError.httpStatusCode(response.statusCode)))
                    UIBlockingProgressHUD.dismiss()
                }
                do {
                    let token = try JSONDecoder().decode(AuthToken.self, from: response.data)
                    completion(.success(token))
                    UIBlockingProgressHUD.dismiss()
                } catch {
                    completion(.failure(error))
                    UIBlockingProgressHUD.dismiss()
                }
            case .failure(let error):
                completion(.failure(error))
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func login(user: UserModel, completion: @escaping (Result<AuthToken, Error>) -> Void) {
        UIBlockingProgressHUD.show()
        provider.request(.login(login: user.login, password: user.password)) { result in
            switch result {
            case .success(let response):
                do {
                    let token = try JSONDecoder().decode(AuthToken.self, from: response.data)
                    completion(.success(token))
                    UIBlockingProgressHUD.dismiss()
                } catch {
                    completion(.failure(error))
                    UIBlockingProgressHUD.dismiss()
                }
            case .failure(let error):
                completion(.failure(error))
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}
