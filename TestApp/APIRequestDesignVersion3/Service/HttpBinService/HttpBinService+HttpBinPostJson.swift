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
        var setting: RequestBaseSetting
        var path: String {
            return "/post"
        }
        var bodyParams: [String : Any] {
            return ["foo": foo]
        }

        let foo: String
        init(setting: RequestBaseSetting, foo: String){
            self.setting = setting
            self.foo = foo
        }
    }

    struct HttpBinPostJsonResponse: Codable {
        struct JsonData: Codable{
            let value: String
        }
        let json: JsonData
    }
}
