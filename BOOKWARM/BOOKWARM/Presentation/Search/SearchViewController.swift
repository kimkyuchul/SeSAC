//
//  SearchViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import UIKit

final class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "찾기"
        setLayout()
    }
    
    func setLayout() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.xImage, style: .plain, target: self, action: #selector(dismissTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func dismissTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
