//
//  BookCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingTitle: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        self.layer.cornerRadius = Metric.inset
        self.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
    
    private func setLayout() {
        titleLabel.font = .systemFont(ofSize: 20)
        ratingTitle.font = .systemFont(ofSize: 14)

        posterImageView.contentMode = .scaleAspectFit
    }

}

extension BookCollectionViewCell {
    func configureCell(row: Movie) {
        titleLabel.text = row.title
        ratingTitle.text = String(row.rate)
        posterImageView.image = UIImage(named: "\(row.title)")
    }
}
