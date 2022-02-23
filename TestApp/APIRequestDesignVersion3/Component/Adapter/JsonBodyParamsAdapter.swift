//
//  JsonBodyParamsAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// JsonBodyParams 的 轉接器
struct JsonBodyParamsAdapter: RequestAdapter {
    let bodyParams: [String: Any]
    func adapted(_ request: URLRequest) throws -> URLRequest {
        var request = request
        request.httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
        return request
    }
}
