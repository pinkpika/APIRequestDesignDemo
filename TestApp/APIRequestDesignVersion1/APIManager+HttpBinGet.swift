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

    struct HttpBinGetResponse: Codable{
        struct Args: Codable{
            let value: String
        }
        let args: Args
        let origin: String
        let url: String
    }

    func requestHttpBinGet(completion: @escaping ((Result<HttpBinGetResponse,APIManagerError>) -> Void)){
        
        // TODO: Part1 組合 Request，使用方法或擴充封裝類似的邏輯
        guard let url = URL(string: "https://httpbin.org/get?value=1") else { return }
        var request = URLRequest(url: url)
        request.method = .get
        request.addHeaderAuthToken()
        
        // TODO: Part2 發動 API，如果有需求也可抽換
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // TODO: Part3 處理 Response，使用方法或擴充封裝類似的邏輯
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        dataTask.resume()
    }
    
    func requestHttpBinGetByAlamofire(completion: @escaping ((Result<HttpBinGetResponse,APIManagerError>) -> Void)){
        guard let url = URL(string: "https://httpbin.org/get?value=1") else { return }
        var request = URLRequest(url: url)
        request.method = .get
        request.addHeaderAuthToken()
        AF.request(request).response {
            response in
            self.handleResponse(data: response.data, response: response.response, error: response.error, completion: completion)
        }
    }
}
