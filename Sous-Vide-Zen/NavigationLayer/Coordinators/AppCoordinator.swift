//
//  AppCoordinator.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    override func start() {
//        showOnboardingFlow()
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

//MARK: - Navigation methods

private extension AppCoordinator {
    func showRegistrationFlow() {
        guard let navigationController else { return }
        SceneFactory.makeRegistrationFlow(finishDelegate: self, navigationController: navigationController, coordinator: self)
    }
    
    func showMainFlow() {
        guard let navigationController else { return }
        let tabBarController = SceneFactory.makeMainFlow(finishDelegate: self, coordinator: self)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        remove(childCoordinator: childCoordinator)
        
        switch childCoordinator.type {
        case .app:
            return
        default:
            navigationController?.popViewController(animated: false)
        }
    }
    
    
}
