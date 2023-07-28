//
//  CustomTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configureCell(todo: ToDo) {
        mainTitleLabel.text = todo.main
        subTitleLabel.text = todo.sub
        
        if todo.done {
            checkImageView.image = UIImage(systemName: "checkmark.square.fill")
        } else {
            checkImageView.image = UIImage(systemName: "checkmark.square")
        }
        
        if todo.like {
            likeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
