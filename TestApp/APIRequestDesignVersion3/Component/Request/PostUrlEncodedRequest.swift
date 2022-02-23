//
//  PostUrlEncodedRequest.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 基底Request - PostUrlEncoded
protocol PostUrlEncodedRequest: Request{

    /// Path
    var path: String { get }
    
    /// ContentType
    var contentType: ContentType { get }
    
    /// Body Params
    var bodyParams: [String: Any] { get }
}

/// 基底Request - PostUrlEncoded
extension PostUrlEncodedRequest {
    
    var method: HTTPMethod {
        return .post
    }

    var contentType: ContentType {
        return .urlencoded
    }
    
    /// 預設的轉接器
    var adapters: [RequestAdapter] {
        return [
            PathAdapter(path: path),
            HTTPMethodAdapter(method: method),
            ContentTypeAdapter(contentType: contentType),
            CMUrlFormBodyParamsAdapter(bodyParams: bodyParams)
        ]
    }
    
    /// 預設的決策路徑
    var decisions: [Decision] {
        return [
            ParseResultDecision()
        ]
    }
}
