//
//  SearchCollectionViewCell.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/21.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        imageView.backgroundColor = .systemPink
        label.text = "init(coder:) has not been implemented"
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
