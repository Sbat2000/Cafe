//
//  SceneDelegate.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 22.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationVC = CoffeeShopListModuleBuilder.build()
        let token = AppDependencies.shared.tokenStorage.getToken()
        print(token)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}

