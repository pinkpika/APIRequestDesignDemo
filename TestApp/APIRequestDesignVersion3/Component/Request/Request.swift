//
//  Request.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// Request基礎設定
protocol RequestBaseSetting {
    
    /// Domain
    var domain: String { get }
}

/// 基底Request
protocol Request {

    /// 基底Response
    associatedtype Response: Decodable
    
    /// Request基礎設定
    var setting: RequestBaseSetting { get set }
    
    /// HTTPMethod
    var method: HTTPMethod { get }

    /// 請求轉接器(發送前處理)
    var adapters: [RequestAdapter] { get }
    
    /// 決策路徑(接收回應後處理)
    var decisions: [Decision] { get }
}
    
/// 基底Request
extension Request {
    
    /// 建立Request
    func buildRequest() throws -> URLRequest {
        guard let url = URL(string: setting.domain) else {
            throw ApiComponentError.requestAdapterFailure(error: nil)
        }
        let request = URLRequest(url: url)
        return try adapters.reduce(request) { try $1.adapted($0) }
    }
}
