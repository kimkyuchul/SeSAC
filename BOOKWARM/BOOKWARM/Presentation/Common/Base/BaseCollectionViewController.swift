//
//  BaseViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

protocol BaseCollectionViewControllerProtocol: AnyObject {
    
    func setCollectionView()
    
    func setRegister()
    
    func setLayout()
}

class BaseCollectionViewController: UICollectionViewController, BaseCollectionViewControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        setRegister()
        setCollectionView()
        setLayout()
    }
    
    func setCollectionView() {
        collectionView.backgroundColor = .white
    }
    
    func setRegister() {}
    
    func setLayout() {
        self.view.backgroundColor = .white
    }
}

