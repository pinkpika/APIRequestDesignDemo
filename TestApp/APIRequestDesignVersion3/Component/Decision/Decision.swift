//
//  Decision.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策方式
protocol Decision {
    
    /// 是否要應用
    func shouldApply<Req: Request>(request: Req, data: Data?, response: HTTPURLResponse) -> Bool
    
    /// 應用方式
    func apply<Req: Request>(
        request: Req,
        data: Data?,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
}

/// 決策方式 - Array
extension Array where Element == Decision {
    
    /// 替換元素
    mutating func replacing(originDecision: Decision, newDecision: Decision) -> Array {
        if let index = firstIndex(where: {
            let originDecisionName = "\(String(describing: type(of: originDecision.self)))"
            let findDecisionName = "\(String(describing: type(of: $0.self)))"
            return originDecisionName == findDecisionName
        }) {
            self[index] = newDecision
        }
        return self
    }
}
