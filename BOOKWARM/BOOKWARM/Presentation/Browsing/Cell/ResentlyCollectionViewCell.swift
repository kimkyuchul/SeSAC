//
//  ResentlyCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/03.
//

import UIKit

final class ResentlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ResentlyCollectionViewCell"

    @IBOutlet weak var resentlyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resentlyImageView.contentMode = .scaleAspectFill
    }
}

extension ResentlyCollectionViewCell {
    func configureCell(row: Movie) {
        resentlyImageView.image = UIImage(named: "\(row.title)")
    }
}
