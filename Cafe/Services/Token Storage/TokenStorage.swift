//
//  TokenStorage.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 24.12.2023.
//

import SwiftKeychainWrapper

protocol TokenStorageProtocol {
    func saveToken(_ token: String)
    func getToken() -> String?
    func deleteToken()
}

final class TokenStorage: TokenStorageProtocol {
    private let tokenKey = "UserToken"

     func saveToken(_ token: String) {
         KeychainWrapper.standard.set(token, forKey: tokenKey)
     }

     func getToken() -> String? {
         return KeychainWrapper.standard.string(forKey: tokenKey)
     }

     func deleteToken() {
         KeychainWrapper.standard.removeObject(forKey: tokenKey)
     }
}

