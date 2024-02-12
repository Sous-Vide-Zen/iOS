//
//  AppCoordinator.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    override func start() {
        //showOnboardingFlow()
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

//MARK: - Navigation methods

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController else { return }
        let onboardingCoordinator = OnBoardingCoordinator(type: .onboarding, navigationController: navigationController, finishDelegate: self)
        add(childCoordinator: onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func showMainFlow() {
        guard let navigationController else { return }
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeCoordinator.finishDelegate = self
        homeCoordinator.start()
        
        let notificationNavigationController = UINavigationController()
        let notificationCoordinator = NotificationCoordinator(type: .home, navigationController: notificationNavigationController)
        notificationNavigationController.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell"), tag: 1)
        notificationCoordinator.finishDelegate = self
        notificationCoordinator.start()
        
        let bookmarksNavigationController = UINavigationController()
        let bookmarksCoordinator = BookmarksCoordinator(type: .home, navigationController: bookmarksNavigationController)
        bookmarksNavigationController.tabBarItem = UITabBarItem(title: "Bookmarks", image: UIImage(systemName: "bookmark"), tag: 2)
        bookmarksCoordinator.finishDelegate = self
        bookmarksCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .home, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        
        add(childCoordinator: homeCoordinator)
        add(childCoordinator: notificationCoordinator)
        add(childCoordinator: bookmarksCoordinator)
        add(childCoordinator: profileCoordinator)
        
        let tabBarControllers = [homeNavigationController, notificationNavigationController, bookmarksNavigationController, profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
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
