//
//  PathAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// Path 的 轉接器
struct PathAdapter: RequestAdapter {
    let path: String
    func adapted(_ request: URLRequest) throws -> URLRequest {
        guard let domain = request.url?.absoluteString else {
            throw ApiComponentError.requestAdapterFailure(error: nil)
        }
        guard var urlComponent = URLComponents(string: domain) else {
            throw ApiComponentError.requestAdapterFailure(error: nil)
        }
        urlComponent.path = path

        guard let url = urlComponent.url else {
            throw ApiComponentError.requestAdapterFailure(error: nil)
        }
        return URLRequest(url: url)
    }
}
