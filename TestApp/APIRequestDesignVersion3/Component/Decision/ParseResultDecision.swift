//
//  ParseResultDecision.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策方式 - 轉換物件
struct ParseResultDecision: Decision {
    
    func shouldApply<Req: Request>(request: Req, data: Data?, response: HTTPURLResponse) -> Bool {
        return true
    }

    func apply<Req: Request>(
        request: Req,
        data: Data?,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {
        
        guard let data = data else {
            closure(.errored(ApiComponentError.nilData))
            return
        }
        
        do {
            let value = try JSONDecoder().decode(Req.Response.self, from: data)
            closure(.done(value))
        } catch {
            closure(.errored(ApiComponentError.decodeFailure(data: data, error: error)))
        }
    }
}

extension ParseResultDecision: CustomStringConvertible{
    var description: String {
        return "ParseResult"
    }
}
