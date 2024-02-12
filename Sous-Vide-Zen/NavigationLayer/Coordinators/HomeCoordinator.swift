//
//  HomeCoordinator.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

import UIKit

final class HomeCoordinator: Coordinator {
    override func start() {
        let vc = CreateUserViewController()
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
