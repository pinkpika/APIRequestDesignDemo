//
//  ViewController.swift
//  TestApp
//
//  Created by cm0620 on 2022/1/25.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.requestHttpBinGetByURLSession {
            result in
            switch result{
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
        
        APIManager.shared.requestHttpBinGetByAlamofire {
            result in
            switch result{
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
        
        APIManager.shared.requestHttpBinPost {
            result in
            switch result{
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
