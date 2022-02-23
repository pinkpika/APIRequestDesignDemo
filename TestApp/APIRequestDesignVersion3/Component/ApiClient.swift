//
//  ApiClient.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation
import Alamofire

/// Api Client - URLSession
struct ApiNativeClient: ApiComponentSendable{
    let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
    func sendRequest(request: URLRequest, queue: DispatchQueue, handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.dataTask(with: request) {
            (data, response, error) in
            queue.async {
                handler(data, response, error)
            }
        }
    }
}

/// Api Client - Alamofire
struct ApiAlamofireClient: ApiComponentSendable{
    func sendRequest(request: URLRequest, queue: DispatchQueue, handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        AF.request(request).response(queue: queue) {
            response in
            handler(response.data, response.response, response.error)
        }
    }
}

/// Api Client - Mock
struct ApiMockClient: ApiComponentSendable{
    var data: Data?
    var statusCode: Int
    func sendRequest(request: URLRequest, queue: DispatchQueue, handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: "https://www.apimockclient.com/") else { return }
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        queue.async {
            handler(data, response, nil)
        }
    }
}
