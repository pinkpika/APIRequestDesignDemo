//
//  PostJsonRequest.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 基底Request - PostJson
protocol PostJsonRequest: Request {

    /// Path
    var path: String { get }
    
    /// ContentType
    var contentType: ContentType { get }
    
    /// Body Params
    var bodyParams: [String: Any] { get }
}

/// 基底Request - PostJson
extension PostJsonRequest {
    
    var method: HTTPMethod {
        return .post
    }

    var contentType: ContentType {
        return .json
    }
    
    /// 預設的轉接器
    var adapters: [RequestAdapter] {
        return [
            PathAdapter(path: path),
            HTTPMethodAdapter(method: method),
            ContentTypeAdapter(contentType: contentType),
            JsonBodyParamsAdapter(bodyParams: bodyParams)
        ]
    }
    
    /// 預設的決策路徑
    var decisions: [Decision] {
        return [
            ParseResultDecision()
        ]
    }
}
