//
//  RetryDecision.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策方式 - 重新嘗試 (有需求要重新呼叫才需要)
struct RetryDecision: Decision {
    
    let leftCount: Int
    
    func shouldApply<Req: Request>(request: Req, data: Data?, response: HTTPURLResponse) -> Bool {
        let isStatusCodeValid = (200..<300).contains(response.statusCode)
        return !isStatusCodeValid && leftCount > 0
    }

    func apply<Req: Request>(
        request: Req,
        data: Data?,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {
        var tempDecisions = request.decisions
        let retryDecision = RetryDecision(leftCount: leftCount - 1)
        let newDecisions = tempDecisions.replacing(originDecision: self, newDecision: retryDecision)
        closure(.restartWith(newDecisions))
    }
}

extension RetryDecision: CustomStringConvertible{
    var description: String {
        return "Retry"
    }
}
