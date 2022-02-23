//
//  DecisionAction.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策動作
/// - continueWith: 接續決策
/// - restartWith: 重頭開始
/// - errored: 發生錯誤
/// - done: 結束決策
enum DecisionAction<Req: Request> {
    case continueWith(Data?, HTTPURLResponse)
    case restartWith([Decision])
    case errored(Error)
    case done(Req.Response)
}

extension DecisionAction: CustomStringConvertible{
    var description: String {
        switch self {
        case .continueWith(_, _):
            return "➡️"
        case .restartWith(_):
            return "🔄"
        case .errored(_):
            return "Error!!!⛔⛔⛔"
        case .done(_):
            return "Success!!!🙆🙆🙆"
        }
    }
}
