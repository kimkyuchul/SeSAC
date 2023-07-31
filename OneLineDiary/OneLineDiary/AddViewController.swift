//
//  AddViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "추가 확인"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(closeAction))
        navigationItem.leftBarButtonItem?.tintColor = .green
    }
    
    @objc func closeAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}

