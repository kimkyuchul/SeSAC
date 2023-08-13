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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
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
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
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
        headerImageview.image = UIImage(systemName: "star")
        titleLabel.text = "SPIDER-MAN: ACROSS THE SPIDER"
        overviewTitleLabel.text = "overview"
        overviewLabel.text = "An intelligenceoperativeoperativeoperativeoperativeoperativeoperativeoperative operative for a shadowy "
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
            make.top.equalTo(headerImageview.snp.bottom).offset(-50)
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
