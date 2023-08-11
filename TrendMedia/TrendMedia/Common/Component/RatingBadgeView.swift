//
//  RatingBadgeView.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit

final class RatingBadgeView: UIStackView {
    
    private let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    private let ratingBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
        axis = .horizontal
        alignment = .fill
        spacing = 1
        ratingBadgeLabel.text = "4.98"
        self.backgroundColor = .red
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        [badgeImageView, ratingBadgeLabel].forEach { subView in
            self.addArrangedSubview(subView)
        }
    }
    
    private func setConstraints() {
        ratingBadgeLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
}
