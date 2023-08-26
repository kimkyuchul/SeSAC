//
//  BaseViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit
import RxSwift

@objc
protocol BaseViewControllerProtocol: AnyObject {
    func setHierarchy()
    func setConstraints()
    func setLayout()
    func setDelegate()
    func setNavigationBar()
    @objc optional func bind()
     
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setConstraints()
        setLayout()
        setDelegate()
        setNavigationBar()
        bind()
    }
    
    func setHierarchy() {}
    
    func setConstraints() {}
    
    func setLayout() {
        self.view.backgroundColor = .systemBackground
    }
    
    func setDelegate() {}
    
    func setNavigationBar() {}
    
    func bind() {}
    
}
