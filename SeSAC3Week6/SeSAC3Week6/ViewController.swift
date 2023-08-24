//
//  ViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/21.
//

import UIKit

// 오토리사이징과 오토레이아웃은 같이 사용하지 못함.
// AutoResizingMask, AUtoLayout => 스토리보드 대응
// NSLayoutConstraint => 코드베이스 대응
// translatesAutoresizingMaskIntoConstraints를 false 하는 이유

class ViewController: UIViewController {
    
    //1. 뷰객체 프로퍼티 선언(클래스 인스턴스 생성)
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutAnchor()
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // 프레임 기반 레이아웃 잡기
        emailTextField.frame = CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 100, height: 50)
        
        emailTextField.keyboardType = .numberPad
        emailTextField.placeholder = "닉네임"
        emailTextField.backgroundColor = .magenta
        passwordTextField.backgroundColor = .brown
        
        //addConstraints
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        
        let trailng = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50)
        
        view.addConstraints([leading, trailng, height, top])
    }
    
    @objc func signButtonClicked() {
        let vc = LocationViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }
    
    
    private func setLayoutAnchor() {
        view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .blue
        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            //            signButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            //            signButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
    }
    
}

