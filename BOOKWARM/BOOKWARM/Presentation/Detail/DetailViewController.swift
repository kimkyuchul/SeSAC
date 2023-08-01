//
//  DetailViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import UIKit



final class DetailViewController: UIViewController {
    
     var viewModel: DetailViewModel!
        
    @IBOutlet weak var detailBackView: UIView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            viewModel = DetailViewModel()
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.tintColor = UIColor.black
        bind()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func bind() {
        viewModel.binding = { [weak self] in
            guard let data = self?.viewModel.movie else { return }
            self?.detailTitleLabel.text = data.title
            self?.detailImageView.image = UIImage(named: "\(data.title)")
            
            var rateString: String {
                return "평균 평점은: \(data.rate)"
            }
            self?.ratingLabel.text = rateString
            self?.setlikeButton(data.like)
        }
    }
    
    private func setLayout() {
        detailBackView.backgroundColor = .white
        
        detailTitleLabel.textColor = .white
        detailTitleLabel.font = .systemFont(ofSize: 24)
        
        detailImageView.contentMode = .scaleAspectFill
        
        ratingLabel.textColor = .darkGray
        ratingLabel.font = .italicSystemFont(ofSize: 14)
        
        likeButton.tintColor = .yellow
    }
    
    private func setlikeButton(_ bool: Bool) {
        if bool {
            likeButton.setImage(UIImage.likeButtonTappedImage, for: .normal)
        } else {
            likeButton.setImage(UIImage.likeButtonImage, for: .normal)
        }
    }
}
