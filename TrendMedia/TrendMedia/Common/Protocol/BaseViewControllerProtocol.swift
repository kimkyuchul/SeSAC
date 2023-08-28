//
//  BaseViewControllerProtocol.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/28.
//

import Foundation

@objc
protocol BaseViewControllerProtocol: AnyObject {
    func setHierarchy()
    func setConstraints()
    func setLayout()
    func setDelegate()
    func setNavigationBar()
    @objc optional func bind()
     
}
