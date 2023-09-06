//
//  SearchViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import UIKit
import Kingfisher

final class SearchViewController: UIViewController {

    @IBOutlet weak var searchcollectionView: UICollectionView!
    
    var viewModel: SearchViewModel!
    
    private var data: BookRealmModel?
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            viewModel = SearchViewModel(bookRepository: BookRepository())
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.tertiarySystemGroupedBackground
        self.title = "찾기"
        setCollectionView()
        setLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
        
    @objc func dismissTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func bind() {
        viewModel.getBookObservar = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchcollectionView.reloadData()
            }
        }
        
        viewModel.addBookObservar = { [weak self] _, data in
            self?.data = data
            self?.showAlertMessage(title: "추가 성공", button: "닫기")
        }
        
        viewModel.addErrorObservar = { [weak self] error in
            self?.showAlertMessage(title: "추가 실패 \(error.localizedDescription)", button: "닫기")
        }
    }
    
    private func setLayout() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.xImage, style: .plain, target: self, action: #selector(dismissTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = Metric.inset
        flowLayout.minimumLineSpacing = Metric.inset
        flowLayout.sectionInset = UIEdgeInsets(top: Metric.inset, left: Metric.inset, bottom: Metric.inset, right: Metric.inset)
        let size:CGFloat = (searchcollectionView.getDeviceWidth() - (Metric.inset * 3))
        flowLayout.itemSize = CGSize(width: size / 2, height: size / 2)
        searchcollectionView.collectionViewLayout = flowLayout
        
        searchcollectionView.delegate = self
        searchcollectionView.dataSource = self
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        searchcollectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.BookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        let row = self.viewModel.BookList[indexPath.row]
        
        cell.configureBookCell(row: row)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.saveBookdata(indexPath: indexPath, book: viewModel.BookList)
        
        let cell = collectionView.cellForItem(at: indexPath) as! BookCollectionViewCell
        
        guard let data = self.data else { return }
        
        ImageFileManager.shared.saveImageToDocument(fileName: "\(data._id).jpg", image: cell.posterImageView.image ?? UIImage())
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
        // 현재 보여지는 화면의 좌측상단, contentOffset.y(scroll view bounds origin y)
        let offsetY = scrollView.contentOffset.y
        // 화면에 보이지 않는 모든 collectionView 영역을 포함하는 size
        let contentHeight = scrollView.contentSize.height
        // 현재 collectionView의 height
        let visibleHeight = scrollView.frame.height
        
        if offsetY > contentHeight - visibleHeight && !viewModel.isEnd {
            viewModel.getBookData(page: viewModel.currentPage)
        }
    }

    }
    
extension SearchViewController {
    func showAlertMessage(title: String, button: String = "확인", handler: (() -> ())? = nil ) { //매개변수 기본값
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default) { _ in
            handler?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
