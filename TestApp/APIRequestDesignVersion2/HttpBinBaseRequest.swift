//
//  HttpBinBaseRequest.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/21.
//

import Foundation

class HttpBinBaseRequest: BaseRequest{
    
    /// Domain
    override var domain: String {
        return "https://httpbin.org/"
    }
}
