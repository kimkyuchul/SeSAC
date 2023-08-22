//
//  SnapViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/22.
//

import UIKit

import SnapKit

/*
 1. addSubView
 2. superView
 3. offset, inset
 4. left, right 현지화 대응 RTL
*/

class SnapViewController: UIViewController {
    
    let redView = UIView()
    let whiteView = UIView()
    let blueView = UIView()
    let yellowView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .magenta
        
        blueView.addSubview(yellowView)
        yellowView.backgroundColor = .yellow
        yellowView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.top.equalToSuperview()
        }
        
        view.addSubview(redView)
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(blueView)
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { make in
//            make.centerX.centerY.equalToSuperview()
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        view.addSubview(whiteView)
        whiteView.backgroundColor = .white
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        
    }
    
    

}
