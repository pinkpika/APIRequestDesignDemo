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
        var setting: RequestBaseSetting
        var path: String {
            return "/get"
        }
        var queryParams: [String : String]?{
            return ["foo": foo]
        }

        let foo: String
        init(setting: RequestBaseSetting, foo: String){
            self.setting = setting
            self.foo = foo
        }
    }

    struct HttpBinGetResponse: Codable {
        struct Args: Codable {
            let foo: String
        }
        let args: Args
    }
}
