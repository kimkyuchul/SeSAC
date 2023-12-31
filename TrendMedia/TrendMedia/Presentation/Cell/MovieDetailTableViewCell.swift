//
//  MovieDetailTableViewCell.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/12.
//

import UIKit

final class MovieDetailTableViewCell: BaseTableViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.addArrangedSubviews(titleLabel, infoLabel)
        return stackView
    }()
        
    override func setHierarchy() {
        [posterImageView, titleLabel, infoLabel].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    override func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalToSuperview().inset(10)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(10)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(10).priority(.high)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    override func setLayout() {
        self.backgroundColor = .clear
    }
}

extension MovieDetailTableViewCell {
    func configureCell(row: Cast) {
        titleLabel.text = row.name
        infoLabel.text = row.character
        posterImageView.kf.setImage(with: URL(string: URLConstants.image + (row.profilePath ?? "")))
    }
}

