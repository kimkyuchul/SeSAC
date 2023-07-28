//
//  BaseViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit

protocol BaseViewControllerProtocol: AnyObject {

    func setHierarchy()
    
    func setConstraints()
    
    func setLayout()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    func setLayout() {
        self.view.backgroundColor = .white
    }
    
    func setHierarchy() {}
    
    func setConstraints() {}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitle()
        configureNavigationButton()
        configureNavigationsearchBar()
        
        setHierarchy()
        setConstraints()
        setLayout()
    }
    
    
}

extension BaseViewController {
    private func configureNavigationTitle() {
        self.navigationController?.configureNavigationBarAppearance(bgColor: UIColor.tertiarySystemGroupedBackground)
        self.navigationController?.configureLargeTitle(true)
    }
    
    private func configureNavigationButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(systemName:"ellipsis.circle"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor =  UIColor.systemOrange
    }

    private func configureNavigationsearchBar() {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchBar
    }
}
