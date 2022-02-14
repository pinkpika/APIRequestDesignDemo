//
//  APIManager+HttpBinGet.swift
//  TestApp
//
//  Created by cm0630 on 2022/2/15.
//

import Foundation
import Alamofire

// MARK: - HttpBin(https://httpbin.org/#/HTTP_Methods)
extension APIManager{
    
    enum APIManagerError: Error{
        case requestError(error: Error)
        case nilData
        case decodeError
    }
    
    struct HttpBinGetResponse: Codable{
        struct Args: Codable{
            let value: String
        }
        let args: Args
        let origin: String
        let url: String
    }
    
    func requestHttpBinGetByURLSession(completion: @escaping ((Result<HttpBinGetResponse,APIManagerError>) -> Void)){
        guard let url = URL(string: "https://httpbin.org/get?value=1") else { return }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error{
                completion(.failure(.requestError(error: error)))
                return
            }
            guard let data = data else {
                completion(.failure(.nilData))
                return
            }
            guard let response = try? JSONDecoder().decode(HttpBinGetResponse.self, from: data) else {
                completion(.failure(.decodeError))
                return
            }
            completion(.success(response))
        }
        dataTask.resume()
    }
    
    func requestHttpBinGetByAlamofire(completion: @escaping ((Result<HttpBinGetResponse,APIManagerError>) -> Void)){
        guard let url = URL(string: "https://httpbin.org/get?value=1") else { return }
        let request = URLRequest(url: url)
        AF.request(request).responseDecodable {
            (afResponse: AFDataResponse<HttpBinGetResponse>) in
            switch afResponse.result{
            case .success(let response):
                completion(.success(response))
            case .failure(let afError):
                completion(.failure(.requestError(error: afError)))
            }
        }
    }
}
