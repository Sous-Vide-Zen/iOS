//
//  NetworkService.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 02.12.2023.
//

fileprivate struct Endpoints {
    let createUser = "http://127.0.0.1:8000/api/v1/auth/users/"
}

import Foundation

final class NetworkService {
    
    func createUser(user: User, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        guard let url = URL(string: Endpoints().createUser) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            completion(.failure(error))
            print("Ошибка в Экодере: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            
            
            guard let data else { return }
            
            do {
                print(data)
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
                let user = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(user))
                print(user)
            } catch {
                completion(.failure(error))
                print("Ошибка в Декодере: \(error.localizedDescription)")
            }
        }.resume()
    }
}
