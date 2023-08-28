//
//  AddView.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

class AddView: BaseView {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .brown
        view.contentMode = .scaleToFill
        return view
    }()
    let searchButton = {
        let v = UIButton()
        v.backgroundColor = .systemPink
        return v
    }()
    
    
    override func configureView() {
        [photoImageView, searchButton].forEach { view in
            addSubview(view)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(self).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
    }
}
