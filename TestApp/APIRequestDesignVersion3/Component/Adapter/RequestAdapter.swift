//
//  RequestAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 請求轉接器
protocol RequestAdapter {
    func adapted(_ request: URLRequest) throws -> URLRequest
}
