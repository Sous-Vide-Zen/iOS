//
//  BookmarksCoordinator.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

final class BookmarksCoordinator: Coordinator {
    override func start() {
        let vc = CreateUserViewController()
        vc.view.backgroundColor = .green
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
