//
//  BeerListViewController.swift
//  AlamofirePractice
//
//  Created by 김규철 on 2023/08/08.
//

import UIKit

import Kingfisher

final class BeerListViewController: UIViewController {
    
    private var beerList: [Beer] = [] {
        didSet {
            beerCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var beerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setNavgation()
        self.view.backgroundColor = UIColor.tertiarySystemGroupedBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBeerData()
    }
    
    private func setNavgation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Beer보단 Soju"
    }
    
    private func setCollectionView() {
        
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        
        let nib = UINib(nibName: BeerListCollectionViewCell.identifier, bundle: nil)
        beerCollectionView.register(nib, forCellWithReuseIdentifier: BeerListCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumInteritemSpacing = 20
//        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        let size: CGFloat = (UIScreen.main.bounds.width - (20 * 4))
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
        beerCollectionView.collectionViewLayout = flowLayout
        
        beerCollectionView.backgroundColor = UIColor.tertiarySystemGroupedBackground
    }
}

extension BeerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCollectionViewCell.identifier, for: indexPath) as? BeerListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.beerTitleLabel.text = self.beerList[indexPath.item].name
        cell.brewedTitle.text = self.beerList[indexPath.item].first_brewed
        cell.beerImageView.kf.setImage(with: URL(string: self.beerList[indexPath.item].imageURL))
        cell.descriptionTextView.text = self.beerList[indexPath.item].description
        
        return cell
    }
}

extension BeerListViewController {
    private func getBeerData() {
        NetworkService.shared.getBeerListData { [weak self] result in
            DispatchQueue.main.async {
                self?.beerList = result
            }
        }
    }
}
