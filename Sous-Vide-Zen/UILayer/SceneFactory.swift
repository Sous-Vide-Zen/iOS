//
//  SceneFactory.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 13.02.2024.
//

import UIKit

struct SceneFactory {
    static func makeRegistrationFlow(finishDelegate: CoordinatorFinishDelegate, navigationController: UINavigationController, coordinator: AppCoordinator) {
        let onboardingCoordinator = RegistrationCoordinator(type: .onboarding, navigationController: navigationController, finishDelegate: finishDelegate)
        coordinator.add(childCoordinator: onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    static func makeMainFlow(finishDelegate: CoordinatorFinishDelegate, coordinator: AppCoordinator) -> TabBarController {
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeCoordinator.finishDelegate = finishDelegate
        homeCoordinator.start()
        
        let notificationNavigationController = UINavigationController()
        let notificationCoordinator = NotificationCoordinator(type: .home, navigationController: notificationNavigationController)
        notificationNavigationController.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell"), tag: 1)
        notificationCoordinator.finishDelegate = finishDelegate
        notificationCoordinator.start()
        
        let bookmarksNavigationController = UINavigationController()
        let bookmarksCoordinator = BookmarksCoordinator(type: .home, navigationController: bookmarksNavigationController)
        bookmarksNavigationController.tabBarItem = UITabBarItem(title: "Bookmarks", image: UIImage(systemName: "bookmark"), tag: 2)
        bookmarksCoordinator.finishDelegate = finishDelegate
        bookmarksCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .home, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        profileCoordinator.finishDelegate = finishDelegate
        profileCoordinator.start()
        
        coordinator.add(childCoordinator: homeCoordinator)
        coordinator.add(childCoordinator: notificationCoordinator)
        coordinator.add(childCoordinator: bookmarksCoordinator)
        coordinator.add(childCoordinator: profileCoordinator)
        
        let tabBarControllers = [homeNavigationController, notificationNavigationController, bookmarksNavigationController, profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        return tabBarController
    }
}
