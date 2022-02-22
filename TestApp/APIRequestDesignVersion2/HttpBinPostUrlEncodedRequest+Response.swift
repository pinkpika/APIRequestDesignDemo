//
//  HttpBinPostUrlEncodedRequest+Response.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/22.
//

import Foundation

class HttpBinPostUrlEncodedRequest: HttpBinBaseRequest{
    
    override var path: String {
        return "post"
    }
    
    override var method: HttpMethod {
        return .post
    }
    
    override var contentType: ContentType {
        return .urlencoded
    }
    
    var value: String = "我是資料"
    
    func setData(value: String) -> Self{
        self.value = value
        return self
    }
}

struct HttpBinPostJsonResponse: Codable{
    struct JsonData: Codable{
        let value: String
    }
    let json: JsonData
    let origin: String
    let url: String
}
