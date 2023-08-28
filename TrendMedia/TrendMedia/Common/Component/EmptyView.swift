//
//  EmptyView.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/18.
//

import UIKit

final class EmptyView: BaseView {
    
    private let emptyViewLabel: UILabel = {
        let label = UILabel()
        label.text = "데이터가 없어요."
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    convenience init(isHidden: Bool) {
        self.init()
        self.isHidden = isHidden
    }
    
    override func setHierarchy() {
        self.addSubview(emptyViewLabel)
    }
    
    override func setConstraints() {
        emptyViewLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func setLayout() {
        super.setLayout()
    }
}
