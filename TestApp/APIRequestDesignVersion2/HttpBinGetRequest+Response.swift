//
//  HttpBinGetRequest+Response.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/21.
//

import Foundation

class HttpBinGetRequest: HttpBinBaseRequest{
    
    override var path: String {
        return "get"
    }
    
    var value: String = "abc"
    
    func setData(value: String) -> Self{
        self.value = value
        return self
    }
}

struct HttpBinGetResponse: Codable{
    struct Args: Codable{
        let value: String
    }
    let args: Args
    let origin: String
    let url: String
}
