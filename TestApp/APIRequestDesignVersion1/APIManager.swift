//
//  APIManager.swift
//  TestApp
//
//  Created by cm0630 on 2022/2/15.
//

import Foundation

/// API 管理者
class APIManager{
    
    static let shared = APIManager()
    private init(){}
    
    /// 處理回應
    func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ((Result<T,APIManagerError>) -> Void)){
        if let error = error{
            completion(.failure(.requestError(error: error)))
            return
        }
        if let statusCode = (response as? HTTPURLResponse)?.statusCode{
            print(statusCode)
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

// MARK: - 錯誤物件
extension APIManager{
    
    /// 錯誤物件
    enum APIManagerError: Error{
        case requestError(error: Error)
        case nilData
        case decodeError
    }
}
