//
//  ThirdViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/26.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class ThirdViewController: BaseViewController {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "TrendMedia는 근처의 상영관 정보도 제공합니다."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let imageView: UIImageView = {
        let v = UIImageView()
        v.image = PageViewType.third.image
        v.contentMode = .scaleToFill
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.cgColor
        v.clipsToBounds = true
        return v
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("홈으로가기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        bind()
    }
    
    override func bind() {
        button.rx.tap
            .bind {
                UserDefaultManager.isFirstLogin = true
                
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                let rootVC = TabBarController()
                sceneDelegate.window?.rootViewController = rootVC
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.layer.cornerRadius = 20
        button.layer.cornerRadius = 20
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(imageView)
        view.addSubview(button)
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
        
        button.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20).priority(.high)
            $0.height.equalTo(50)
        }
    }
}
