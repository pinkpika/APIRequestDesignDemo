//
//  HttpBinPostRequest.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/21.
//

import Foundation

class HttpBinPostRequest: HttpBinBaseRequest{
    
    override var path: String {
        return "post"
    }
    
    override var method: HttpMethod {
        return .post
    }
    
    override var contentType: ContentType {
        return .json
    }
    
    var value: String = "我是資料"
    
    func setData(value: String) -> Self{
        self.value = value
        return self
    }
}

struct HttpBinPostResponse: Codable{
    struct JsonData: Codable{
        let value: String
    }
    let json: JsonData
    let origin: String
    let url: String
}
