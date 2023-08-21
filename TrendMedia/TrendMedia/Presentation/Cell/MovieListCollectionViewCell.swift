//
//  MovieListCollectionViewCell.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit
import Kingfisher

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        return view
    }()
    private let imageBackView = UIView()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let ratingBadge = RatingBadgeView()
     private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    private let originalTitleLabel: UILabel = {
       let label = UILabel()
       label.font = .boldSystemFont(ofSize: 16)
       label.numberOfLines = 0
        label.textColor = .gray
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
        stackView.addArrangedSubviews(titleLabel, releaseDateLabel)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        [posterImageView, ratingBadge].forEach { view in
            imageBackView.addSubview(view)
        }

        contentView.addSubview(backView)

        [imageBackView, titleLabel, originalTitleLabel, releaseDateLabel].forEach { view in
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
            make.height.equalTo(backView.snp.height).multipliedBy(0.7)
        }

        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        ratingBadge.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(5)
//            make.trailing.equalToSuperview().inset(5).priority(.high)
            make.height.equalTo(posterImageView.snp.height).multipliedBy(0.1)
        }
        
        originalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(posterImageView.snp.height).multipliedBy(0.1)
        }
        
        // 공간이 남을 경우 titleLabel의 크기는 유지하고 originalTitleLabel의 길이가 늘어난다.
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        // 공간이 부족할 경우 titleLabel의 크기는 유지하고 originalTitleLabel의 길이가 줄어든다.
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(5).priority(.high)
            make.bottom.equalToSuperview().inset(10).priority(.low)
            make.height.equalTo(titleLabel.snp.height)
        }
    }
    
    private func setLayout() {
        backView.layer.cornerRadius = 20
        backView.clipsToBounds = true

        imageBackView.layer.cornerRadius = 20
        imageBackView.clipsToBounds = true
    }
}

extension MovieListCollectionViewCell {
    func movieConfigureCell(row: MovieDetail) {
        titleLabel.text = row.title
        originalTitleLabel.text = row.original_title
        ratingBadge.setRatingLabelText(text: String(row.vote_average))
        posterImageView.kf.setImage(with: URL(string: URLConstants.image + (row.poster_path ?? "")))
        releaseDateLabel.text = row.release_date
    }
    
    func similarConfigureCell(row: SimilarData) {
        titleLabel.text = row.title
        ratingBadge.setRatingLabelText(text: String(row.voteAverage))
        posterImageView.kf.setImage(with: URL(string: URLConstants.image + (row.posterPath ?? "") ))
        releaseDateLabel.text = row.releaseDate
    }
    
    func recommendationConfigureCell(row: RecommendaionData) {
        titleLabel.text = row.title
        ratingBadge.setRatingLabelText(text: String(row.voteAverage))
        posterImageView.kf.setImage(with: URL(string: URLConstants.image + (row.posterPath ?? "") ))
        releaseDateLabel.text = row.releaseDate
    }
}
