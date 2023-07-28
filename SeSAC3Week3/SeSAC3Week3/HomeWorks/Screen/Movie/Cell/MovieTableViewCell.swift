//
//  MovieTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit

import Kingfisher

final class MovieTableViewCell: UITableViewCell {
    
    static let CellIdentifier = "MovieTableViewCell"
    
    private let backView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    private let IDLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        setViewHierarchy()
        setConstraints()
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setViewHierarchy() {
        
        [yearLabel, typeLabel].forEach { view in
            horizontalStackView.addArrangedSubview(yearLabel)
            horizontalStackView.addArrangedSubview(typeLabel)
        }
        
        [titleLabel, horizontalStackView, IDLabel].forEach { view in
            verticalStackView.addArrangedSubview(titleLabel)
            verticalStackView.addArrangedSubview(horizontalStackView)
            verticalStackView.addArrangedSubview(IDLabel)
        }
        
        contentView.addSubview(backView)
        backView.addSubview(verticalStackView)
        backView.addSubview(posterImageView)
    }
    
    private func setConstraints() {
        
        [backView, titleLabel, yearLabel, typeLabel, IDLabel, posterImageView, horizontalStackView, verticalStackView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            verticalStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            verticalStackView.trailingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: -16),
            verticalStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            yearLabel.widthAnchor.constraint(equalTo: typeLabel.widthAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalTo: IDLabel.heightAnchor, multiplier: 1.0)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalToConstant: 54),
            posterImageView.heightAnchor.constraint(equalToConstant: 54),
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16)
            
        ])
    
    }
    
    private func setLayout() {
        backView.backgroundColor = .white
    }
}

extension MovieTableViewCell {
    func configureCell(row: Movie) {
        titleLabel.text = row.Title
        yearLabel.text = row.Year
        typeLabel.text = "Category: \(row.`Type`)"
        IDLabel.text = "OMDB ID: \(row.imdbID)"
        posterImageView.kf.setImage(with: URL(string: row.Poster))
    }
}
