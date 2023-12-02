//
//  CreateUserViewController.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 02.12.2023.
//

import UIKit

final class CreateUserViewController: UIViewController {
    
    //MARK: - UI Elements
    
    let user = User(username: "Ivan4", email: "ivan4@ivan.ru", password: "VeryLongPassword123.")
    
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        networkService.createUser(user: user) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
}
