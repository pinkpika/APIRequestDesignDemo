//
//  DecisionRecord.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// 決策紀錄
struct DecisionRecord<Req: Request>{
    
    /// 決策物件
    var decision: Decision
    
    /// 是否應用
    var isApply: Bool
    
    /// 決策動作
    var action: DecisionAction<Req>?
}
