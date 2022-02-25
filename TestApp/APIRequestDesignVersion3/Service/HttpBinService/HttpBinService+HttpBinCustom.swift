//
//  HttpBinService+HttpBinCustom.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/25.
//

import Foundation

extension HttpBinService{
    
    struct HttpBinCustomRequest: Request {

        typealias Response = HttpBinCustomResponse
        var setting: RequestBaseSetting = defaultSetting
        
        var method: HTTPMethod {
            return .get // TODO: - Method
        }

        var adapters: [RequestAdapter] {
            return [
                // TODO: - 請求轉接器
            ]
        }
        
        var decisions: [Decision] {
            return [
                // TODO: - 決策路徑
            ]
        }
    }

    struct HttpBinCustomResponse: Codable {
        // TODO: - 回應物件
    }
}
