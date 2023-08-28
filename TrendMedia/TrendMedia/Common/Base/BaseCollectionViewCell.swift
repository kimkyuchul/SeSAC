//
//  BaseCollectionViewCell.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

import SnapKit
import RxSwift


class BaseCollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    
    var disposeBag: DisposeBag = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
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

