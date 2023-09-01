//
//  HomeViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/31.
//

import UIKit

final class HomeViewController: BaseViewController {

    private let homeView = HomeView()
    
    override func loadView() {
        homeView.delegate = self
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        print(self, #function)
    }
    
    deinit {
        print(self, #function)
    }
}

extension HomeViewController: HomeViewProtocol {
    func dldSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}
