//
//  SceneDelegate.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 22.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var startViewController: UIViewController?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        if let token = AppDependencies.shared.tokenStorage.getToken() {
            startViewController = CoffeeShopListModuleBuilder.build()
        } else {
            startViewController = RegistrationModuleBuilder.build()
        }
        let navigationVC = UINavigationController(rootViewController: startViewController ?? UIViewController())
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
    
    static func getCurrentWindow() -> UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return nil }
        return windowScene.windows.first(where: { $0.isKeyWindow })
    }
}

