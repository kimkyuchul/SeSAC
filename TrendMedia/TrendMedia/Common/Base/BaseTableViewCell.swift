//
//  BaseTableViewCell.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

import SnapKit
import RxSwift


class BaseTableViewCell: UITableViewCell, BaseViewProtocol {
    
    var disposeBag: DisposeBag = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setConstraints()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setHierarchy() { }
    
    func setConstraints() { }
    
    func setLayout() {}
}
