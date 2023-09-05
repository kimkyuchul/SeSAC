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
        print(viewModel.BookList)
        bind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        setNavigation()
        setaddTarget()
        self.detailTitleLabel.text = viewModel.BookList?.title
        self.detailImageView.image = ImageFileManager.shared.loadImageFromDocument(fileName: "\(viewModel.BookList!._id).jpg".trimmingWhitespace())
        detailImageView.backgroundColor = .brown
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        viewModel.updateBookData(text: detailTextField.text)
//    }
    
    
    @objc
    func dismissAction() {
        ImageFileManager.shared.removeImageFromDocument(fileName: "\(viewModel.BookList!._id).jpg")
        viewModel.deleteBookData()
        navigationController?.popViewController(animated: true)
    }
        
    private func bind() {
        guard let data = viewModel.BookList else { return }
        
        self.detailTitleLabel.text = viewModel.BookList?.title
        self.detailImageView.image = ImageFileManager.shared.loadImageFromDocument(fileName: "\(data._id).jpg".trimmingWhitespace())
        var rateString: String {
            return "가격은: \(data.price)"
        }
        self.ratingLabel.text = rateString
        self.detailTextField.text = data.overview
        
        self.detailTextViewCounterLabel.text = "메모의 총 양은:  \(data.overview?.count ?? 0)"
        
        //        viewModel.binding = { [weak self] in
        //
        //            }
    }
    
    private func setNavigation() {
        self.navigationItem.backAction = UIAction(handler: {[weak self] _ in
            self?.viewModel.updateBookData(text: self?.detailTextField.text ?? "")
            self?.navigationController?.popViewController(animated: true)
        })
        
        switch viewModel.navigation {
        case .add: break
        case .edit:
            setDismissButton()
        }
    }
    
    private func setaddTarget() {
        likeButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
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
