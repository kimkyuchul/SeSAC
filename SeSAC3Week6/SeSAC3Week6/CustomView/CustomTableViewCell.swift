//
//  CustomTableViewCell.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/25.
//

import UIKit

import SnapKit

class CustomTableViewCell: UITableViewCell {

    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        button.backgroundColor = .green
        label.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setLayout() {
        contentView.addSubview(label)
        contentView.addSubview(button)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(5)
            make.size.equalTo(30)
        }
    }

}
