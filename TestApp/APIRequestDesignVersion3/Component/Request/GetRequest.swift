//
//  GetRequest.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 基底Request - Get
protocol GetRequest: Request {

    /// Path
    var path: String { get }
    
    /// Query Params
    var queryParams: [String: String]? { get }
}

/// 基底Request - Get
extension GetRequest {
    
     var method: HTTPMethod {
        return .get
    }
    
    /// 預設的轉接器
    var adapters: [RequestAdapter] {
        return [
            PathAdapter(path: path),
            HTTPMethodAdapter(method: method),
            QueryParamsAdapter(queryParams: queryParams)
        ]
    }
    
    /// 預設的決策路徑
    var decisions: [Decision] {
        return [
            ParseResultDecision()
        ]
    }
}
