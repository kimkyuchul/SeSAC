//
//  SearchCollectionViewCell.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleToFill
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    
    override func setConstaints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
