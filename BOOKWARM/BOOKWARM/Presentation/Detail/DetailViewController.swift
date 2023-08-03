//
//  DetailViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import UIKit

final class DetailViewController: BaseViewController {
    
     var viewModel: DetailViewModel!
        
    @IBOutlet weak var detailBackView: UIView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var detailTextViewCounterLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            viewModel = DetailViewModel()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.tintColor = UIColor.black
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        setNavigation()
    }
    
    @objc
    func dismissAction() {
        dismiss(animated: true)
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
            self?.detailTextField.text = data.overview
            
            self?.detailTextViewCounterLabel.text = "줄거리의 총 양은: \(data.overview.count)"
        }
    }
        
    private func setNavigation() {
        switch viewModel.navigation {
        case .add: break
        case .edit:
            setDismissButton()
        }
    }
    
    private func setDismissButton() {
        let xButton = UIBarButtonItem(
            image: UIImage.xImage,
            style: .plain,
            target: self,
            action: #selector(dismissAction)
        )
        
        navigationItem.leftBarButtonItem = xButton
    }
    
    override func setDelegate() {
        detailTextField.delegate = self
    }
        
    override func setLayout() {
        super.setLayout()
        
        detailBackView.backgroundColor = .white
        
        detailTitleLabel.textColor = .white
        detailTitleLabel.font = .systemFont(ofSize: 24)
        
        detailImageView.contentMode = .scaleAspectFill
        
        ratingLabel.textColor = .darkGray
        ratingLabel.font = .italicSystemFont(ofSize: 14)
        
        likeButton.tintColor = .yellow
        
        myTextField.placeholder = Literal.commentplaceholder
        
    }
    
    private func setlikeButton(_ bool: Bool) {
        if bool {
            likeButton.setImage(UIImage.likeButtonTappedImage, for: .normal)
        } else {
            likeButton.setImage(UIImage.likeButtonImage, for: .normal)
        }
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        self.detailTextViewCounterLabel.text = "줄거리의 총 양은: \(textView.text.count)"
        
        
        if textView.text.isEmpty {
            self.detailTextViewCounterLabel.text = "줄거리가 없습니다."
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Literal.placeholder {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Literal.placeholder
            textView.textColor = .lightGray
        }
    }
}
