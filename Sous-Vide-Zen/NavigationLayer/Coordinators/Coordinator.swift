//
//  Coordinator.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

import UIKit

enum CoordinatorTypes {
    case app
    case onboarding
    case home
    case notification
    case bookmarks
    case profile
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorTypes { get }
    var navigationController: UINavigationController? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func add(childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func remove(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}


class Coordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]
    var type: CoordinatorTypes
    var navigationController: UINavigationController?
    var finishDelegate: CoordinatorFinishDelegate?
    
    init(childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](), type: CoordinatorTypes, navigationController: UINavigationController, finishDelegate: CoordinatorFinishDelegate? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
    }
    
    deinit {
        print("coordinator deinited \(type)")
        childCoordinators.forEach { $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }
    
    func start() {
        print("coordinator start")
    }
    
    func finish() {
        print("coordinator finish")
    }
    
    
}
