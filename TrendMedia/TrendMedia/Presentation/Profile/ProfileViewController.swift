//
//  ProfileViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

final class ProfileViewController: BaseViewController {

    private lazy var buttonView: [ProfileButtonView] = (1...4).map { [weak self] index in
        let button = ProfileButtonView(index: Int(index) - 1)
        button.setUp(title: ProfileType.allCases[index - 1].title)
        button.delegate = self
        return button
    }
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    private var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "프로필 설정"
    }
    
    override func setHierarchy() {
        view.addSubview(mainStackView)
        buttonView.forEach { mainStackView.addArrangedSubview($0) }
    }
    
    override func setConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalToSuperview().inset(20).priority(.low)
        }
    }
}

extension ProfileViewController: ProfileButtonDelegate {
    func didSelectProfileButton(at index: Int) {
        self.index = index
        let profileType = ProfileType.allCases[index]
        let vc = ProfileDetailViewController()
        vc.delegate = self
        switch profileType {
        case .name:
            vc.title = profileType.title
            navigationController?.pushViewController(vc, animated: true)
        case .userName:
            vc.title = profileType.title
            navigationController?.pushViewController(vc, animated: true)
        case .gender:
            vc.title = profileType.title
            vc.completionHandler = { text in
                self.buttonView[self.index ?? 0].valueField.placeholder = text
            }
            navigationController?.pushViewController(vc, animated: true)
        case .introduce:
            vc.title = profileType.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProfileViewController: ProfileDetailDelegate {
    func didUpdate(at text: String) {
        let profileType = ProfileType.allCases[self.index ?? 0]
        switch profileType {
        case .name:
            buttonView[self.index ?? 0].valueField.placeholder = text
        case .userName:
            buttonView[self.index ?? 0].valueField.placeholder = text
        case .gender:
            print(text)
        case .introduce:
            buttonView[self.index ?? 0].valueField.placeholder = text
        }
    }
}
