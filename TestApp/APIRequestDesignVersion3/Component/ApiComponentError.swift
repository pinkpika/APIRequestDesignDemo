//
//  ApiComponentError.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 錯誤物件
enum ApiComponentError: Error {
    case requestAdapterFailure(error: Error?)
    case nilData
    case nonHTTPResponse
    case apiFailure(data: Data?, response: URLResponse?, error: Error?)
    case decodeFailure(data: Data?, error: Error?)
}
