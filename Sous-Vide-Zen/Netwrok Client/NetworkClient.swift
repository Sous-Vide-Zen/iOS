//
//  NetworkService.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 02.12.2023.
//

fileprivate struct Endpoints {
    let createUser = "/api/v1/auth/users/"
    let createToken = "http://127.0.0.1:8000/api/v1/auth/jwt/create"
}

import Foundation

final class NetworkClient {
    
    func createUser(user: User, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        var request = URLRequest.makeHTTPRequest(path: Endpoints().createUser, httpMethod: "POST")
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
    
    func objectTask<T: Decodable>(for request: URLRequest,
                                  completion: @escaping(Result<T, Error>) -> Void) -> URLSessionTask {
        let fulfillCompletionOnMainThread: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                fulfillCompletionOnMainThread(.failure(NetworkError.urlRequestError(error)))
            } else if let data,
                      let response,
                      let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200..<300 ~= statusCode {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        decoder.dateDecodingStrategy = .iso8601
                        let result = try decoder.decode(T.self, from: data)
                        fulfillCompletionOnMainThread(.success(result))
                    } catch {
                        fulfillCompletionOnMainThread(.failure(NetworkError.decode(error)))
                    }
                } else {
                    fulfillCompletionOnMainThread(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else {
                fulfillCompletionOnMainThread(.failure(NetworkError.urlSessionError))
            }
        }
        return task
    }
}
