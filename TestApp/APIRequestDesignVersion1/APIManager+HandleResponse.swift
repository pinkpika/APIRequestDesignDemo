//
//  APIManager+HandleResponse.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/17.
//

import Foundation

extension APIManager{
    
    func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ((Result<T,APIManagerError>) -> Void)){
        if let error = error{
            completion(.failure(.requestError(error: error)))
            return
        }
        guard let data = data else {
            completion(.failure(.nilData))
            return
        }
        guard let response = try? JSONDecoder().decode(T.self, from: data) else {
            completion(.failure(.decodeError))
            return
        }
        completion(.success(response))
    }
}
