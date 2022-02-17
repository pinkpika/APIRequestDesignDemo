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
        button.setTitle("APIRequestDesignVersion1 call apis", for: .normal)
        button.addAction(UIAction(handler: {
            action in
            APIManager.shared.requestHttpBinGetByURLSession {
                result in print(result)
            }
            APIManager.shared.requestHttpBinGetByAlamofire {
                result in print(result)
            }
            APIManager.shared.requestHttpBinPost {
                result in print(result)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    var version2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("APIRequestDesignVersion2 call apis", for: .normal)
        button.addAction(UIAction(handler: {
            action in
        }), for: .touchUpInside)
        return button
    }()
    
    var version3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("APIRequestDesignVersion3 call apis", for: .normal)
        button.addAction(UIAction(handler: {
            action in
        }), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        version1.frame = CGRect(x: 0, y: 100, width: 300, height: 50)
        view.addSubview(version1)
        version2.frame = CGRect(x: 0, y: 150, width: 300, height: 50)
        view.addSubview(version2)
        version3.frame = CGRect(x: 0, y: 200, width: 300, height: 50)
        view.addSubview(version3)
    }
}
