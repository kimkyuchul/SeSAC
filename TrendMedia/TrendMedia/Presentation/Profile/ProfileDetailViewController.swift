//
//  ProfileDetailViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

protocol ProfileDetailDelegate: AnyObject {
    func didUpdate(at text: String)
}

final class ProfileDetailViewController: BaseViewController {
    
    private let mainView = ProfileDetailView()
    
    weak var delegate: ProfileDetailDelegate?
    
    var completionHandler: ((String) -> Void)?

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.didUpdate(at: mainView.getTextFieldText() ?? "")
        completionHandler?(mainView.getTextFieldText() ?? "")
    }
    
    override func setLayout() {
        super.setLayout()
    }
}
