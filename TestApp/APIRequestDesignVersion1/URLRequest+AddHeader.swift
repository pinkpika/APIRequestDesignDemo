//
//  URLRequest+AddHeader.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/17.
//

import Foundation

extension URLRequest{
    
    @discardableResult
    mutating func addHeaderAuthToken() -> URLRequest{
        self.addValue("Bearer ......", forHTTPHeaderField: "Authorization")
        return self
    }
    
    @discardableResult
    mutating func addHeaderAcceptJson() -> URLRequest{
        self.addValue("application/json", forHTTPHeaderField: "accept")
        return self
    }
    
    @discardableResult
    mutating func addHeaderContentTypeJson() -> URLRequest{
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return self
    }
    
    @discardableResult
    mutating func addHeaderContentTypeURLEncoded() -> URLRequest {
        self.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return self
    }
}
