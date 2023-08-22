//
//  KakaoProfileViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/22.
//

import UIKit

import SnapKit

class KakaoProfileViewController: UIViewController {
    
    private let xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()
    private let giftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.imageView?.tintColor = .white
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    private let calenderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.imageView?.tintColor = .white
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .white
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    private lazy var hearderStackView: UIStackView = {
        let v = UIStackView()
        v.addArrangedSubview(giftButton)
        v.addArrangedSubview(calenderButton)
        v.addArrangedSubview(settingButton)
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.spacing = 10
        return v
    }()
    private let photoImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.backgroundColor = .systemCyan
         imageView.contentMode = .scaleAspectFill
         return imageView
     }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "김규철김규철김규철김규철이최고"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let chettingButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .small
        configuration.title = "나와의 채팅"
        configuration.image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 3
        configuration.imagePlacement = .top
        let button = UIButton()
        button.configuration = configuration
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    private let profileButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .small
        configuration.title = "프로필 편집"
        configuration.image = UIImage(systemName: "repeat")?.withRenderingMode(.alwaysTemplate)
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 3
        configuration.imagePlacement = .top
        let button = UIButton()
        button.configuration = configuration
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    private let storyButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .small
        configuration.title = "카카오스토리"
        configuration.image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 3
        configuration.imagePlacement = .top
        let button = UIButton()
        button.configuration = configuration
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    private lazy var bottomStackView: UIStackView = {
        let v = UIStackView()
        v.addArrangedSubview(chettingButton)
        v.addArrangedSubview(profileButton)
        v.addArrangedSubview(storyButton)
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.spacing = 20
        return v
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        setHierachy()
        setConstraints()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        giftButton.layer.cornerRadius = giftButton.frame.size.height / 2
        calenderButton.layer.cornerRadius = 0.5 * calenderButton.bounds.size.width
        settingButton.layer.cornerRadius = 0.5 * settingButton.bounds.size.width
        photoImageView.layer.cornerRadius = photoImageView.frame.size.height / 2
    }
        
    private func setHierachy() {
        view.addSubview(xButton)
        view.addSubview(hearderStackView)
        view.addSubview(photoImageView)
        view.addSubview(nameLabel)
        view.addSubview(underLine)
        view.addSubview(bottomStackView)
    }
    
    private func setConstraints() {
        xButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leadingMargin.equalTo(10)
            make.size.equalTo(30)
        }
        
        giftButton.snp.makeConstraints { make in
            make.size.equalTo(xButton.snp.size)
        }
        
        hearderStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.3)
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(14)
            make.height.equalTo(20)
            make.centerX.equalTo(photoImageView.snp.centerX)
            make.leading.trailing.equalToSuperview().inset(20).priority(.high)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(30).priority(.low)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.centerX.equalToSuperview()
        }
        
    }

}
