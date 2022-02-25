//
//  HttpBinService+HttpBinGetPostJson.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

extension HttpBinService{
    
    struct HttpBinPostJsonRequest: PostJsonRequest {

        typealias Response = HttpBinPostJsonResponse
        var setting: RequestBaseSetting = defaultSetting
        var path: String {
            return "/post"
        }
        var bodyParams: [String : Any] {
            return ["foo": foo]
        }

        let foo: String
    }

    struct HttpBinPostJsonResponse: Codable {
        struct JsonData: Codable{
            let foo: String
        }
        let json: JsonData
    }
}
