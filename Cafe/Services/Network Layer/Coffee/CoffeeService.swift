//
//  CoffeeService.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import Foundation
import Moya

enum CoffeeRequestError: Error, Equatable {
    case httpStatusCode(Int)
    case decode
    case unauthorized
}

protocol CoffeeServiceProtocol {
    func getCoffeeShops(token: String, completion: @escaping (Result<[CoffeeShop], Error>) -> Void)
}

final class CoffeeService: CoffeeServiceProtocol {
    let provider = MoyaProvider<CoffeeAPI>()
    
    func getCoffeeShops(token: String, completion: @escaping (Result<[CoffeeShop], Error>) -> Void) {
        UIBlockingProgressHUD.show()
        provider.request(.getCoffeeShops(token: token)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    do {
                        let coffeeShops = try JSONDecoder().decode([CoffeeShop].self, from: response.data)
                        completion(.success(coffeeShops))
                        UIBlockingProgressHUD.dismiss()
                    } catch {
                        completion(.failure(error))
                        UIBlockingProgressHUD.dismiss()
                    }
                case 401:
                    completion(.failure(CoffeeRequestError.unauthorized))
                    UIBlockingProgressHUD.dismiss()
                default:
                    completion(.failure(CoffeeRequestError.httpStatusCode(response.statusCode)))
                    UIBlockingProgressHUD.dismiss()
                }
            case let .failure(error):
                completion(.failure(error))
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}
