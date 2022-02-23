//
//  HttpBinService+HttpBinGet.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

extension HttpBinService{
    
    struct HttpBinGetRequest: GetRequest {

        typealias Response = HttpBinGetResponse
        var setting: RequestBaseSetting = defaultSetting
        var path: String {
            return "/get"
        }
        var queryParams: [String : String]?{
            return ["foo": foo]
        }
        
        let foo: String
    }

    struct HttpBinGetResponse: Codable {
        struct Args: Codable {
            let foo: String
        }
        let args: Args
    }
}
