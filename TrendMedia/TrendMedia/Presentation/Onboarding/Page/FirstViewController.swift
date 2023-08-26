//
//  FirstViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/26.
//

import UIKit

import SnapKit

final class FirstViewController: BaseViewController {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 상영 중인 영화 중\n 인기 있는 영화 리스트를 만나봐요."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let imageView: UIImageView = {
        let v = UIImageView()
        v.image = PageViewType.first.image
        v.contentMode = .scaleToFill
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.cgColor
        v.clipsToBounds = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
    }
    
    override func viewDidLayoutSubviews() {
        imageView.layer.cornerRadius = 20
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(imageView)
    }

    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(view.snp.width)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20).priority(.high)
        }
    }
}
