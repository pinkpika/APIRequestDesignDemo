//
//  BadStatusCodeDecision.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策方式 - 錯誤狀態碼
struct BadStatusCodeDecision: Decision {
    
    func shouldApply<Req: Request>(request: Req, data: Data?, response: HTTPURLResponse) -> Bool {
        return !(200..<300).contains(response.statusCode)
    }

    func apply<Req: Request>(
        request: Req,
        data: Data?,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {
        closure(.errored(ApiComponentError.badStatusCode(data: data, statusCode: response.statusCode)))
    }
}

extension BadStatusCodeDecision: CustomStringConvertible{
    var description: String {
        return "BadStatusCode"
    }
}
