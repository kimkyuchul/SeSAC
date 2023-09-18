//
//  RandomCollectionViewCell.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/18.
//

import UIKit

class RandomCollectionViewCell: UICollectionViewCell {
    
     var imageView: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.contentMode = .scaleAspectFill
        imageVIew.backgroundColor = .systemRed
        return imageVIew
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setHierarchy() {
        self.addSubview(imageView)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
