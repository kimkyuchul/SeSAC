//
//  ViewController.swift
//  SeSAC3Recap
//
//  Created by 김규철 on 2023/12/01.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ViewController {
    
    // static func vs class func
    // class에서만 사용가능하고 상속시 재정의 가능
    class func methodSwizzling() {
        
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, origin)
        else {
            print("함수를 찾을 수 없음")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    // 시점이 런타임 시점이다.
    @objc func changeViewWillAppear() {
        // 앱 분석 기능 ..
        print(#function)
    }
}

