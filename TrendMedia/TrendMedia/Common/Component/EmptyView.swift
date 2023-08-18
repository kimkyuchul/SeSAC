//
//  EmptyView.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/18.
//

import UIKit

import SnapKit

final class EmptyView: UIView {
    
    private let emptyViewLabel: UILabel = {
        let label = UILabel()
        label.text = "데이터가 없어요."
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
        self.backgroundColor = .tertiarySystemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(isHidden: Bool) {
        self.init()
        self.isHidden = isHidden
    }
    
    private func setHierarchy() {
        self.addSubview(emptyViewLabel)
    }
    
    private func setConstraints() {
        emptyViewLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
}
