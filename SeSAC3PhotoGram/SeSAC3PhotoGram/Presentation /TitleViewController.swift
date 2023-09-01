//
//  TitleViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

final class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력"
        return view
    }()
    let textView = {
        let v = UITextView()
        v.textColor = .black
        v.backgroundColor = .systemPink
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "끝", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    deinit {
        print(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //Closure - 2
        completionHandler?(textField.text ?? "", 77, false)
        textviewCompletionHandler?(textView.text)
    }
    
    @objc func doneButtonClicked() {
        completionHandler?(textField.text ?? "", 22, true)
        navigationController?.popViewController(animated: true)
    }
    
    //Closure - 1
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    var textviewCompletionHandler: ((String) -> Void)?
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

