//
//  TabBarController.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 12.02.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
//MARK: - LifeCycle
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tabBarController in tabBarControllers {
            self.addChild(tabBarController)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .darkGray
        tabBar.tintColor = .orange
    }
}
