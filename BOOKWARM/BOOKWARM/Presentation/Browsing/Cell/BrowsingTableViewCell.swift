//
//  BrowsingTableViewCell.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/02.
//

import UIKit

final class BrowsingTableViewCell: UITableViewCell {
    
    static let identifier = "BrowsingTableViewCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var runingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
    
    private func setLayout() {
        self.backgroundColor = UIColor.random
        
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .black
        runingTimeLabel.font = .systemFont(ofSize: 14)
        runingTimeLabel.textColor = .black

        posterImageView.contentMode = .scaleAspectFit
    }
}

extension BrowsingTableViewCell {
    func configureCell(row: Movie) {
        titleLabel.text = row.title
        dateLabel.text = row.releaseDate
        runingTimeLabel.text = "러닝타임: \(row.runtime)"
        posterImageView.image = UIImage(named: "\(row.title)")
    }
}
