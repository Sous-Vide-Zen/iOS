//
//  CreateUserViewController.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 02.12.2023.
//

import UIKit

final class CreateUserViewController: UIViewController {
    
    //MARK: - UI Elements
    
    let user = User(username: "Ivan2", email: "ivan2@ivan.ru", password: "VeryLongPassword123.")
    
    struct ExampleRequest: NetworkRequest {
        var endpoint: URL? {
            return URL(string: "http://127.0.0.1:8000/api/v1/auth/users/")
        }

        var httpMethod: HttpMethod {
            return .post
        }

        var dto: Encodable? {
            // Если запрос требует отправки данных, определите их здесь
            return User(username: "Ivan24", email: "ivan24@ivan.ru", password: "VeryLongPassword123.")
        }
    }
    
    struct ExampleRequest2: NetworkRequest {
        var endpoint: URL? {
            return URL(string: "http://127.0.0.1:8000/api/v1/auth/users/")
        }

        var httpMethod: HttpMethod {
            return .get
        }

        var dto: Encodable? {
            // Если запрос требует отправки данных, определите их здесь
            return nil
        }
    }
    
    struct req: NetworkRequest {
        var endpoint: URL?
        var httpMethod: HttpMethod
        var dto: Encodable?
        
        init(endpoint: URL?, httpMethod: HttpMethod, dto: Encodable? = nil) {
            self.endpoint = endpoint
            self.httpMethod = httpMethod
            self.dto = dto
        }
    }
    
    let networkService = NetworkClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
       // view.backgroundColor = .blue
//        createUser()
       // giveMeUsers()
//        networkService.createUser(user: user) { result in
//            switch result {
//            case .success(let user):
//                print(user)
//            case .failure(let error):
//                print(error)
//            }
//        }

    }
    
    func createUser() {
        guard let request = URLRequest.create(request: ExampleRequest()) else { return }
        let task = networkService.objectTask(for: request) { (result: Result<UserResponse, Error>) in
            switch result {
                
            case .success(let response):
                // Успешная регистрация
                print("Зарегистрированный пользователь: \(response.username)")
            case .failure(let error):
                // Ошибка при регистрации
                print("Ошибка регистрации: \(error)")
            }
        }
        task.resume()
    }
    
    func giveMeUsers() {
        guard var request = URLRequest.create(request: ExampleRequest2()) else { return }
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAxNzk2NjMwLCJpYXQiOjE3MDE3OTMwMzAsImp0aSI6ImQ3NmYwNjBjODAyYTQ4ODE4NjY1NzM5ZjUxNTEwYzY3IiwidXNlcl9pZCI6MTF9.1BkkCFZbTEVA5MLsGvGBPeOPoDXEee1UtMr0k1x3SSI"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = networkService.objectTask(for: request) { (result: Result<[UserResponse], Error>) in
            switch result {
                
            case .success(let response):
                // Успешная регистрация
                print("успешно: \(response)")
            case .failure(let error):
                // Ошибка при регистрации
                print("ошибка получения: \(error)")
            }
        }
        task.resume()
    }
}
