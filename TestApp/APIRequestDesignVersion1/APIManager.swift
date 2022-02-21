//
//  APIManager.swift
//  TestApp
//
//  Created by cm0630 on 2022/2/15.
//

import Foundation

/// API 管理者
class APIManager{
    
    static let shared = APIManager()
    private init(){}
    
    enum APIManagerError: Error{
        case requestError(error: Error)
        case nilData
        case decodeError
    }
}
