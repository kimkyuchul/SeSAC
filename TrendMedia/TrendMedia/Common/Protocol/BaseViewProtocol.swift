//
//  BaseViewProtocol.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/28.
//

import Foundation

@objc
protocol BaseViewProtocol: AnyObject {
    func setHierarchy()
    func setConstraints()
    func setLayout()
    @objc optional func bind()
     
}
