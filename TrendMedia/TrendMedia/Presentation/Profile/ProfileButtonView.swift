//
//  ProfileButtonView.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

protocol ProfileButtonDelegate: AnyObject {
    func didSelectProfileButton(at index: Int)
}

final class ProfileButtonView: BaseView {
    
    private let titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .black
        v.font = .boldSystemFont(ofSize: 14)
        v.sizeToFit()
        v.textAlignment = .left
        return v
    }()
    let valueField: UITextField = {
        let v = UITextField()
        v.textColor = .black
        v.font = .boldSystemFont(ofSize: 14)
        v.isUserInteractionEnabled = false
        return v
    }()
    
    weak var delegate: ProfileButtonDelegate?
    
    init(index: Int) {
        super.init(frame: .zero)
        self.tag = index
        setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapView() {
        delegate?.didSelectProfileButton(at: self.tag)
    }
    
    private func setGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func setHierarchy() {
        [titleLabel, valueField].forEach { view in
            addSubview(view)
        }
    }
    
    override func setConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
        valueField.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10).priority(.high)
        }
    }
    
    override func setLayout() {
        super.setLayout()
    }
}

extension ProfileButtonView {
    func setUp(title: String) {
        self.titleLabel.text = title
    }
}
