//
//  ProfileCoordinator.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

final class ProfileCoordinator: Coordinator {
    override func start() {
        let vc = CreateUserViewController()
        vc.view.backgroundColor = .orange
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
