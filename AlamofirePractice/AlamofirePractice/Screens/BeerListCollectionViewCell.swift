//
//  BeerListCollectionViewCell.swift
//  AlamofirePractice
//
//  Created by 김규철 on 2023/08/08.
//

import UIKit

final class BeerListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BeerListCollectionViewCell"

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTitleLabel: UILabel!
    @IBOutlet weak var brewedTitle: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        self.backgroundColor = .brown
    }
    private func setLayout() {
        beerImageView.contentMode = .scaleAspectFit
        beerTitleLabel.textColor = .black
        beerTitleLabel.font = .boldSystemFont(ofSize: 17)
        brewedTitle.textColor = .black
        beerTitleLabel.font = .boldSystemFont(ofSize: 15)
        descriptionTextView.font = .systemFont(ofSize: 13)
        descriptionTextView.isEditable = false
    }

}
