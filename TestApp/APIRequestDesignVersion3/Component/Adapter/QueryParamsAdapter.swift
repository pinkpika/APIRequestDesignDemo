//
//  QueryParamsAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// QueryParams 的 轉接器
struct QueryParamsAdapter: RequestAdapter {
    let queryParams: [String: String]?
    func adapted(_ request: URLRequest) throws -> URLRequest {
        guard let domain = request.url?.absoluteString else {
            throw ApiComponentError.requestAdapterFailure(error: nil)
        }
        guard var urlComponent = URLComponents(string: domain) else {
            throw ApiComponentError.requestAdapterFailure(error: nil)
        }
        
        if let queryParams = queryParams{
            let queryItems = queryParams.map  { URLQueryItem(name: $0.key, value: $0.value) }
            urlComponent.queryItems = queryItems
        }else{
            urlComponent.queryItems = nil
        }

        guard let url = urlComponent.url else {
            throw ApiComponentError.requestAdapterFailure(error: nil)
        }
        return try URLRequest(url: url, method: request.method ?? .get, headers: request.headers)
    }
}
