//
//  HTTPMethodAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// HTTPMethod 的 轉接器
struct HTTPMethodAdapter: RequestAdapter {
    let method: HTTPMethod
    func adapted(_ request: URLRequest) throws -> URLRequest {
        var request = request
        request.httpMethod = method.rawValue
        return request
    }
}
