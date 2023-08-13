//
//  MovieDetailTableViewCell.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/12.
//

import UIKit

import SnapKit

final class MovieDetailTableViewCell: UITableViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "adasdsadasdadad"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "adasdsadasdaadasdsadasdadadadasdsadasdadaddad"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setConstraints()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        [posterImageView, titleLabel, infoLabel].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    private func setConstraints() {
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
    
    private func setLayout() {
        self.backgroundColor = .clear
    }
}
