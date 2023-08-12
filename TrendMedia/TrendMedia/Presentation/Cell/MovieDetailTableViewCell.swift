//
//  MovieDetailTableViewCell.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/12.
//

import UIKit

import SnapKit

final class MovieDetailTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.text = "안녕하세여"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
