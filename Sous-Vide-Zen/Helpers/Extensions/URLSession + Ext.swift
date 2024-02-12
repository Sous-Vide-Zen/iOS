//
//  URLSession + Extension.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 05.12.2023.
//

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case decode(Error)
}

import Foundation

extension  URLSession {
    
    
}
