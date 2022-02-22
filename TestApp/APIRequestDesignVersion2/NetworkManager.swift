//
//  NetworkManager.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/21.
//

import Foundation

/// Network 管理者
class NetworkManager{
    
    static let shared = NetworkManager()
    private init(){}
    
    /// 轉換參數
    private func convertParameters(parameters: [String: Any]) -> [String: String] {
        var temp: [String: String] = [:]
        for one in parameters{
            switch one.value {
            case is String, is Int, is Double, is CustomStringConvertible:
                temp[one.key] = "\(one.value)"
            default:
                break
            }
        }
        return temp
    }
    
    /// 處理回應
    private func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ((Result<T,NetworkManagerError>) -> Void)){
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
extension NetworkManager{
    
    /// 錯誤物件
    enum NetworkManagerError: Error{
        case requestError(error: Error)
        case nilData
        case decodeError
    }
}


// MARK: - Get 相關請求
extension NetworkManager{
    
    /// 發送 Get 請求
    func sendGetRequest<T: Decodable>(urlString: String,
                                      queryItems: [String: Any],
                                      timeoutInterval: TimeInterval,
                                      completion: @escaping ((Result<T,NetworkManagerError>) -> Void)) -> URLSessionDataTask?{
        
        // 組成 Request
        guard var urlComponents = URLComponents(string: urlString) else { return nil }
        urlComponents.queryItems = convertParameters(parameters: queryItems).map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = timeoutInterval
        
        // 發送 Request
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        dataTask.resume()
        return dataTask
    }
}

// MARK: - Post 相關請求
extension NetworkManager{
    
    /// 發送 Post UrlEncoded 請求
    func sendPostUrlEncodedRequest<T: Decodable>(urlString: String,
                                                 urlEncodedParas: [String: Any],
                                                 timeoutInterval: TimeInterval,
                                                 completion: @escaping ((Result<T,NetworkManagerError>) -> Void)) -> URLSessionDataTask?{
        
        // 組成 Request
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        let bodyString = convertParameters(parameters: urlEncodedParas).map{ return "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = timeoutInterval
        
        // 發送 Request
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        dataTask.resume()
        return dataTask
    }
    
    /// 發送 Post JSON 請求
    func sendPostJSONRequest<T: Decodable>(urlString: String,
                                           parameters: [String: Any],
                                           timeoutInterval: TimeInterval,
                                           completion: @escaping ((Result<T,NetworkManagerError>) -> Void)) -> URLSessionDataTask?{
        
        // 組成 Request
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = timeoutInterval
        
        // 發送 Request
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        dataTask.resume()
        return dataTask
        
    }
}
