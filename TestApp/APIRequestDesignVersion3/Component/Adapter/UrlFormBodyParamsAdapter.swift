//
//  UrlFormBodyParamsAdapter.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// UrlFormBodyParams 的 轉接器
struct CMUrlFormBodyParamsAdapter: RequestAdapter {
    
    /// 參數
    let bodyParams: [String: Any]
    
    /// 允許字元 ( 可以自定 )
    var allowedCharacters: CharacterSet = CharacterSet.urlQueryAllowed
    
    func adapted(_ request: URLRequest) throws -> URLRequest {
        var request = request
        let httpBody = bodyParams.map {
            param in
            let key = genPercentEncoding(param.key)
            let value = genPercentEncoding("\(param.value)")
            return "\(key)=\(value)" }.joined(separator: "&")
        request.httpBody = httpBody.data(using: .utf8)
        return request
    }

    func genPercentEncoding(_ query: String) -> String {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? query
        return escapedQuery
    }
}
