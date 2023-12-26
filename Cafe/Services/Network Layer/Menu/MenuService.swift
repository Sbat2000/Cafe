//
//  MenuService.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import Foundation
import Moya

enum MenuRequestError: Error {
    case httpStatusCode(Int)
    case decode
    case unauthorized
}

protocol MenuServiceProtocol {
    func getMenu(token: String, cafeId: Int, completion: @escaping (Result<[MenuItem], Error>) -> Void)
}

final class MenuService: MenuServiceProtocol {
    let provider = MoyaProvider<MenuAPI>()
    
    func getMenu(token: String, cafeId: Int, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        UIBlockingProgressHUD.show()
        provider.request(.getMenu(token: token, id: cafeId)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    do {
                        let menuItems = try JSONDecoder().decode([MenuItem].self, from: response.data)
                        completion(.success(menuItems))
                        UIBlockingProgressHUD.dismiss()
                    } catch {
                        completion(.failure(MenuRequestError.decode))
                        UIBlockingProgressHUD.dismiss()
                    }
                case 401:
                    completion(.failure(MenuRequestError.unauthorized))
                    UIBlockingProgressHUD.dismiss()
                default:
                    completion(.failure(MenuRequestError.httpStatusCode(response.statusCode)))
                    UIBlockingProgressHUD.dismiss()
                }
            case let .failure(error):
                completion(.failure(error))
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}
