//
//  DateViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    // protocol 값 전달 2
    // 프로토콜 내가 가지고 있을게
    weak var delegate: PassDataProtocol?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink

    }
    
    // protocol 값 전달 3
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.receiveDate(date: mainView.getDate())
    }

}
