//
//  HttpBinService+HttpBinGetPostUrlEncoded.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

extension HttpBinService{
    
    struct HttpBinPostUrlEncodedRequest: PostUrlEncodedRequest {

        typealias Response = HttpBinPostUrlEncodedResponse
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

    struct HttpBinPostUrlEncodedResponse: Codable {
        struct Form: Codable {
            let foo: String
        }
        let form: Form
    }
}
