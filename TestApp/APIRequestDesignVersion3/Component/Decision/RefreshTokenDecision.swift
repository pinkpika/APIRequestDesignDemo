//
//  RefreshTokenDecision.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策方式 - 更新Token (有需要身份驗證的才需要)
struct RefreshTokenDecision: Decision {
    
    func shouldApply<Req: Request>(request: Req, data: Data?, response: HTTPURLResponse) -> Bool {
        return response.statusCode == 401 || response.statusCode == 403 // 請依照站台的規定設定
    }

    func apply<Req: Request>(
        request: Req,
        data: Data?,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {

// Todo: - 請自行實作如何 RefreshToken
//        let refreshTokenRequest = RefreshTokenRequest(refreshToken: "refreshToken")
//        ApiNativeClient(session: .shared).send(request: refreshTokenRequest, queue: .main) {
//            result in
//            switch result {
//            case .success(_):
//            let decisionsWithoutRefresh = request.decisions.removing(self)
//                closure(.restartWith(decisionsWithoutRefresh))
//            case .failure(let error):
//                closure(.errored(error))
//        }
        closure(.continueWith(data, response))
    }
}

extension RefreshTokenDecision: CustomStringConvertible{
    var description: String {
        return "RefreshToken"
    }
}
