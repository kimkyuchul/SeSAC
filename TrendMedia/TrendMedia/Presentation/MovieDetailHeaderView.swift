//
//  MovieDetailHeaderView.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/12.
//

import UIKit

import SnapKit

final class MovieDetailHeaderView: UITableViewHeaderFooterView {
    
    private let headerImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
     let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setConstraints()
        headerImageview.backgroundColor = .brown
        overviewLabel.frame.size = overviewLabel.intrinsicContentSize
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setHierarchy() {
        [headerImageview, backView, sectionTitleLabel].forEach { view in
            contentView.addSubview(view)
        }
        
        [titleLabel, overviewTitleLabel, overviewLabel].forEach { view in
            backView.addSubview(view)
        }
    }
    
    func setConstraints() {
        headerImageview.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(headerImageview.snp.bottom).offset(-60)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(headerImageview.snp.height).priority(.low)
        }
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
            make.bottom.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.trailing.leading.equalToSuperview().inset(10)
            make.height.equalTo(16)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(3).priority(.high)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10).priority(.high)
            make.height.equalTo(backView.snp.height).multipliedBy(0.4).priority(.low)
        }
    }
}

extension MovieDetailHeaderView {
    func configureHeader(row: TrandData) {
        if case TrandType.movie.rawValue = row.mediaType {
            titleLabel.text = row.title
        } else {
            titleLabel.text = row.name
            sectionTitleLabel.isHidden = true
        }
        overviewLabel.text = row.overview
        headerImageview.kf.setImage(with: URL(string: URLConstants.image + (row.backdropPath)))
    }
}
