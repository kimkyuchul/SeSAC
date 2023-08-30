//
//  BaseViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()

        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        
    }

}
