//
//  APIManager+HttpBinPostUrlEncoded.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/22.
//

import Foundation

// MARK: - HttpBin(https://httpbin.org/#/HTTP_Methods)
extension APIManager{

    struct HttpBinPostUrlEncodedResponse: Codable{
        struct Form: Codable{
            let value: String
        }
        let form: Form
        let origin: String
        let url: String
    }

    func requestHttpBinPostUrlEncoded(completion: @escaping ((Result<HttpBinPostUrlEncodedResponse,APIManagerError>) -> Void)){
        
        // TODO: Part1 組合 Request，使用方法或擴充封裝類似的邏輯
        guard let url = URL(string: "https://httpbin.org/post") else { return }
        var request = URLRequest(url: url)
        request.method = .post
        request.addHeaderAuthToken()
        request.addHeaderContentTypeURLEncoded()
        request.httpBody = "value=我是資料".data(using: .utf8)
        
        // TODO: Part2 發動 API，如果有需求也可抽換
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // TODO: - Part3 處理 Response，使用方法或擴充封裝類似的邏輯
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        dataTask.resume()
    }
}
