//
//  BaseViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/03.
//

import UIKit

@objc
protocol BaseViewControllerProtocol: AnyObject {
        
    func setHierarchy()
    
    func setConstraints()
    
    func setLayout()
    
    @objc optional func setDelegate()
    
    @objc optional func bind()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setConstraints()
        setLayout()
        setDelegate()
    }
    
    func setHierarchy() {}
    
    func setConstraints() {}
    
    func setLayout() {
        self.view.backgroundColor = .white
    }
    
    func setDelegate() {}
}
