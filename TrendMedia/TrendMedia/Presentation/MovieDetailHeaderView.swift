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
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setConstraints()
        headerImageview.image = UIImage(systemName: "star")
        titleLabel.text = "SPIDER-MAN23: ACROSS THE SPIDER-VERS"
        overviewTitleLabel.text = "overview"
        overviewLabel.text = "An intelligence operative for a shadowy global peacekeeping agency races to stop a hacker from stealing its most valuable — and dangerous — weapon"
        headerImageview.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setHierarchy() {
        [headerImageview, backView].forEach { view in
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
            make.top.equalTo(headerImageview.snp.bottom).offset(-40)
            make.trailing.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(5)
            make.trailing.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(5).priority(.low)
        }
    }
}
