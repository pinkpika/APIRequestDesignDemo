//
//  HttpBinService.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

/// HttpBinService ( https://httpbin.org/#/HTTP_Methods )
struct HttpBinService{
    
    /// 預設設定值
    static var defaultSetting: HttpBinServiceSetting = .init(status: .production)
}

/// HttpBinServiceSetting
struct HttpBinServiceSetting: RequestBaseSetting{
    
    /// 狀態(通常站台會有正式站和測試站，但也有可能更多)
    enum Status: String{
        case debug = "https://httpbin.debug.org"
        case production = "https://httpbin.org"
    }
    
    var status: Status
    var domain: String {
        return status.rawValue
    }
}
