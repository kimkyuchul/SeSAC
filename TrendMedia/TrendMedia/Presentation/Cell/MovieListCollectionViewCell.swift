//
//  MovieListCollectionViewCell.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.isUserInteractionEnabled = false
        return view
    }()
    private let imageBackView = UIView()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        return imageView
    }()
    private let ratingBadge = RatingBadgeView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    // type & adult
    private let mediaInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.addArrangedSubviews(titleLabel, mediaInfoLabel, releaseDateLabel)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
        setLayout()
        titleLabel.text = "스파이더맨아이언맨배트맨집"
        mediaInfoLabel.text = "타입: 무비 / 청소년관람가능"
        releaseDateLabel.text = "2023.08.27"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        [posterImageView, ratingBadge].forEach { view in
            imageBackView.addSubview(view)
        }

        contentView.addSubview(backView)

        [imageBackView, infoStackView].forEach { view in
            backView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }

        imageBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(backView.snp.height).multipliedBy(0.8)
        }

        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        ratingBadge.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(mediaInfoLabel.snp.height)
        }

        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(20).priority(.low)
        }
    }
    
    private func setLayout() {
        backView.layer.cornerRadius = 20
        backView.clipsToBounds = true

        imageBackView.layer.cornerRadius = 20
        imageBackView.clipsToBounds = true
    }
}
