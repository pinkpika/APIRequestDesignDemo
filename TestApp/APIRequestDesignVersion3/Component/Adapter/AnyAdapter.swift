//
//  AnyAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 請求轉接器 - 任意方式
struct AnyAdapter: RequestAdapter {
    let block: (URLRequest) throws -> URLRequest
    func adapted(_ request: URLRequest) throws -> URLRequest {
        return try block(request)
    }
}
