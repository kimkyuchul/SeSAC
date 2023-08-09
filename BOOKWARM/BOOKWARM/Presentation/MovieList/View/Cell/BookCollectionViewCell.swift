//
//  BookCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

typealias ButtonAction = () -> Void

final class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingTitle: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    var likeButtonAction: ButtonAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = Metric.inset
        self.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        setButtonAction()
    }
    
    private func setLayout() {
        self.backgroundColor = UIColor.green
        
        titleLabel.font = .systemFont(ofSize: 20)
        ratingTitle.font = .systemFont(ofSize: 14)

        posterImageView.contentMode = .scaleAspectFit
        
        likeButton.setImage(UIImage.likeButtonImage, for: .normal)
        likeButton.tintColor = UIColor.yellow
    }
    
    private func setButtonAction() {
        
        let likeAction = UIAction { [weak self] _ in
            self?.likeButtonAction?()
        }
        
        likeButton.addAction(likeAction, for: .touchUpInside)
    }

}

extension BookCollectionViewCell {
    func configureCell(row: Movie) {
        titleLabel.text = row.title
        ratingTitle.text = String(row.rate)
        posterImageView.image = UIImage(named: "\(row.title)")
        
        if row.like {
            likeButton.setImage(UIImage.likeButtonTappedImage, for: .normal)
        } else {
            likeButton.setImage(UIImage.likeButtonImage, for: .normal)
        }
    }
    
    func configureBookCell(row: Book) {
        titleLabel.text = row.title
        ratingTitle.text = "\(row.price)"
        posterImageView.setImage(urlString: row.thumbnail)
    }
}
