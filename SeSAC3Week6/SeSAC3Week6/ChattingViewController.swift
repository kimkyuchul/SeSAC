//
//  ChattingViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/22.
//

import UIKit

import SnapKit

class ChattingViewController: UIViewController {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "8월 24일 08시 42분"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private let locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.imageView?.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "서울, 회기동"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private lazy var hearderStackView: UIStackView = {
        let v = UIStackView()
        v.addArrangedSubview(locationButton)
        v.addArrangedSubview(locationLabel)
        v.axis = .horizontal
        v.distribution = .fill
        v.spacing = 8
        return v
    }()
    private let sharedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.imageView?.tintColor = .black
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.titleLabel?.text = "adsadas"
        button.imageView?.tintColor = .black
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    private lazy var buttonStackView: UIStackView = {
        let v = UIStackView()
        v.addArrangedSubview(sharedButton)
        v.addArrangedSubview(reloadButton)
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.spacing = 20
        return v
    }()
    private let firstTextLabel: BasePaddingLabel = {
        let label = BasePaddingLabel()
        label.text = "지금은 구도에요."
        label.sizeToFit()
//        label.sizeThatFits( CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
//        label.frame.size = label.intrinsicContentSize
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let twoTextLabel: BasePaddingLabel = {
        let label = BasePaddingLabel()
        label.text = "78% 만큼 습해요"
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let thirdTextLabel: BasePaddingLabel = {
        let label = BasePaddingLabel()
        label.text = "1 m/s의 바람이 불어요"
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let photoImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.backgroundColor = .systemCyan
        imageView.image = UIImage(systemName: "character.book.closed.fill.ar")
         imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
         return imageView
     }()
    private let fourTextLabel: BasePaddingLabel = {
        let label = BasePaddingLabel()
        label.text = "오늘도 행복한 하루"
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .magenta
        setHierachy()
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        firstTextLabel.layer.cornerRadius = 5
        twoTextLabel.layer.cornerRadius = 5
        thirdTextLabel.layer.cornerRadius = 5
        photoImageView.layer.cornerRadius = 5
    }
    
    private func setHierachy() {
        view.addSubview(dateLabel)
        view.addSubview(hearderStackView)
        view.addSubview(buttonStackView)
        view.addSubview(firstTextLabel)
        view.addSubview(twoTextLabel)
        view.addSubview(thirdTextLabel)
        view.addSubview(photoImageView)
        view.addSubview(fourTextLabel)
    }
    
    private func setConstraints() {
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leadingMargin.equalTo(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(35)
        }

        hearderStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(5)
        }
        
        reloadButton.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            make.trailing.equalToSuperview().inset(20)
        }
        
        firstTextLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30).priority(.low)
        }
        
        twoTextLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTextLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30).priority(.low)
        }
        
        thirdTextLabel.snp.makeConstraints { make in
            make.top.equalTo(twoTextLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30).priority(.low)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalTo(thirdTextLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30).priority(.low)
        }
        
        fourTextLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30).priority(.low)
        }
    }
}
