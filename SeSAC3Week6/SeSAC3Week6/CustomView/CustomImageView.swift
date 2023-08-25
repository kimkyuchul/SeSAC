//
//  CustomImageView.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/25.
//

import UIKit

class CustomImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
        print(frame.width, frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}
