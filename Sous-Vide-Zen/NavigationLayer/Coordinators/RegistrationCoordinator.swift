//
//  OnBoardingCoordinator.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

import UIKit

final class RegistrationCoordinator: Coordinator {
    override func start() {
        let vc = CreateUserViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

