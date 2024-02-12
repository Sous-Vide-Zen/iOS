//
//  SceneDelegate.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 28.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let appCoordinator = AppCoordinator(type: .app, navigationController: navigationController)
        appCoordinator.start()
    }
}

