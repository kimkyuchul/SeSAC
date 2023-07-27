//
//  ShoppingTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    static let CellIdentifier = "ShoppingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setLayout(title: String) {
        textLabel?.text = title
        imageView?.image = UIImage(systemName: "checkmark.square")
        
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.contentMode = .scaleAspectFit
        accessoryView = imageView
    }
    
}
