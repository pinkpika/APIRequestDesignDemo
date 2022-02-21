//
//  BaseRequest.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/21.
//

import Foundation

class BaseRequest{
    
    /// Domain
    var domain: String {
        return ""
    }
    
    /// Path
    var path: String {
        return ""
    }
    
    /// 請求方法
    var method: HttpMethod {
        return .get
    }
    
    /// 內容格式
    var contentType: ContentType {
        return .none
    }
    
    /// Timeout
    var timeoutInterval: TimeInterval {
        return 60
    }
    
    /// 發送請求
    @discardableResult
    func send<T: Decodable>(completion: @escaping ((Result<T,NetworkManager.NetworkManagerError>) -> Void)) -> URLSessionDataTask? {
        let urlString = domain + path
        switch method {
        case .get:
            return NetworkManager.shared.sendGetRequest(urlString: urlString, parameters: getParameters(), timeoutInterval: timeoutInterval, completion: completion)
        case .post where contentType == .urlencoded:
            return NetworkManager.shared.sendPostUrlEncodedRequest(urlString: urlString, urlEncodedParas: getParameters(), timeoutInterval: timeoutInterval, completion: completion)
        case .post where contentType == .json:
            return NetworkManager.shared.sendPostJSONRequest(urlString: urlString, parameters: getParameters(), timeoutInterval: timeoutInterval, completion: completion)
        default:
            return nil
        }
    }
    
    /// 取得參數
    private func getParameters() -> [String: Any] {
        return getParameters(mirror: Mirror(reflecting: self))
    }

    /// 取得參數(使用Mirror所有父類別的參數，並轉換為Dictionary)
    private func getParameters(mirror: Mirror) -> [String: Any] {
        var parameters: [String: Any] = [:]
        if mirror.superclassMirror != nil {
            parameters = parameters.merging(getParameters(mirror: mirror.superclassMirror! )){ $1 }
        }
        for attr in mirror.children {
            if let propertyName = attr.label {
                parameters[propertyName] = attr.value
            }
        }
        return parameters
    }
}

extension BaseRequest{
    enum ContentType{
        case none
        case urlencoded
        case json
    }
    enum HttpMethod{
        case get
        case post
    }
}
