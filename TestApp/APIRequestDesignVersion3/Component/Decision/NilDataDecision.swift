//
//  NilDataDecision.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策方式 - 無內容
struct NilDataDecision: Decision {
    
    func shouldApply<Req: Request>(request: Req, data: Data?, response: HTTPURLResponse) -> Bool {
        return true
    }

    func apply<Req: Request>(
        request: Req,
        data: Data?,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {
        if let req = NilDataResponse(statusCode: response.statusCode) as? Req.Response, data == nil {
            closure(.done(req))
        } else {
            closure(.continueWith(data, response))
        }
    }
}

extension NilDataDecision: CustomStringConvertible{
    var description: String {
        return "NilData"
    }
}

/// Nil Data 回應物件 (當後端定義的正確回應物件(statusCode=2XX)，卻 Data 為空時，可以使用此物件)
struct NilDataResponse: Codable {

    /// 狀態碼
    var statusCode: Int
    
    /// 初始化
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}
