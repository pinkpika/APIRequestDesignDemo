//
//  ContentType.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

enum ContentType: String {
    case json = "application/json"
    case urlencoded = "application/x-www-form-urlencoded; charset=utf-8"
    case multiPartFormData = "multipart/form-data"
}
