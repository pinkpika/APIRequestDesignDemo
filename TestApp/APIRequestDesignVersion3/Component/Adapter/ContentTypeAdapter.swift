//
//  ContentTypeAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// ContentType 的 轉接器
struct ContentTypeAdapter: RequestAdapter {
    let contentType: ContentType
    func adapted(_ request: URLRequest) throws -> URLRequest {
        var request = request
        request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        return request
    }
}
