//
//  ViewController.swift
//  TestApp
//
//  Created by cm0620 on 2022/1/25.
//

import UIKit

class ViewController: UIViewController {
    
    var version1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Version1 call apis", for: .normal)
        button.addAction(UIAction(handler: {
            action in
            APIManager.shared.requestHttpBinGet(value: "xxxx1") {
                result in print(result)
            }
            APIManager.shared.requestHttpBinPostUrlEncoded(value: "xxxx2") {
                result in print(result)
            }
            APIManager.shared.requestHttpBinPostJson(value: "xxxx3") {
                result in print(result)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    var version2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Version2 call apis", for: .normal)
        button.addAction(UIAction(handler: {
            action in
            HttpBinGetRequest().setData(value: "wwww1").send {
                (result: Result<HttpBinGetResponse,NetworkManager.NetworkManagerError>) in
                print(result)
            }
            HttpBinPostUrlEncodedRequest().setData(value: "wwww2").send {
                (result: Result<HttpBinPostUrlEncodedResponse,NetworkManager.NetworkManagerError>) in
                print(result)
            }
            HttpBinPostJsonRequest().setData(value: "wwww3").send {
                (result: Result<HttpBinPostJsonResponse,NetworkManager.NetworkManagerError>) in
                print(result)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    var version3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Version3 call apis", for: .normal)
        button.addAction(UIAction(handler: {
            action in
            let request1 = HttpBinService.HttpBinGetRequest(foo: "123")
            ApiNativeClient(session: .shared).send(request: request1, queue: .main) {
                result in print(result)
            }
            let request2 = HttpBinService.HttpBinPostUrlEncodedRequest(foo: "456")
            ApiNativeClient(session: .shared).send(request: request2, queue: .main) {
                result in print(result)
            }
            let request3 = HttpBinService.HttpBinPostJsonRequest(foo: "789")
            ApiNativeClient(session: .shared).send(request: request3, queue: .main) {
                result in print(result)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    var version3ChangeSettingAll: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Version3 call apis + ChangeSettingAll", for: .normal)
        button.addAction(UIAction(handler: {
            action in
            
            // Case: 整個站台切換正式或測試環境
            HttpBinService.defaultSetting.status = .debug
            let request = HttpBinService.HttpBinGetRequest(foo: "123")
            ApiNativeClient(session: .shared).send(request: request, queue: .main) {
                result in print(result)
            }
            
        }), for: .touchUpInside)
        return button
    }()
    
    var version3ChangeSettingOne: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Version3 call apis + ChangeSettingOne", for: .normal)
        button.addAction(UIAction(handler: {
            action in
            
            // Case: 只切換一道 Api 正式或測試環境
            var request = HttpBinService.HttpBinGetRequest(foo: "123")
            request.setting = HttpBinServiceSetting.init(status: .debug)
            ApiNativeClient(session: .shared).send(request: request, queue: .main) {
                result in print(result)
            }
            
        }), for: .touchUpInside)
        return button
    }()
    
    var version3Mock: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Version3 call apis + Mock", for: .normal)
        button.addAction(UIAction(handler: {
            action in
            
            // Case: 進行 Mock 的測試
            var request = HttpBinService.HttpBinGetRequest(foo: "0000")
            let dataString = """
            {"args":{"foo":"0000"}}
            """
            let apiMockClient = ApiMockClient(data: dataString.data(using: .utf8), statusCode: 200)
            apiMockClient.send(request: request, queue: .main) {
                result in print(result)
            }
            
        }), for: .touchUpInside)
        return button
    }()
    
    lazy var allButtons: [UIButton] = {
        return [
            version1,
            version2,
            version3,
            version3ChangeSettingAll,
            version3ChangeSettingOne,
            version3Mock
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, one) in allButtons.enumerated(){
            one.frame = CGRect(x: 0, y: 100 + index*40, width: 300, height: 40)
            view.addSubview(one)
        }
    }
}
