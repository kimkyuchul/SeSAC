//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 김규철 on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 재사용될 때 이전에 사용했던 데이터 제거
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

}
