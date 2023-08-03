//
//  AddViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

enum TransitionType: String {
    case add = "추가 화면"
    case edit = "수정 화면"
}

class AddViewController: UIViewController {
    
    var type: TransitionType = .add
    
    var data: String = ""
    
    let placeholderText = "내용을 입력하세요."

    @IBOutlet weak var diaryTextview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryTextview.text = data
        
        title = type.rawValue
        
        diaryTextview.delegate = self
        
        switch type {
        case .add:
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(closeAction))
            navigationItem.leftBarButtonItem?.tintColor = .green
        case .edit:
            print("")
        }
        
        if diaryTextview.text.isEmpty {
            diaryTextview.text = placeholderText
            diaryTextview.textColor = .lightGray
        }
    }
    
    @objc func closeAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}

extension AddViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        title = textView.text
    }
    
    //편집이 시작될 때(커서가 시작)
    //플레이스 홀더와 텍스트뷰 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    //편집이 끝날 때(커서가 없어지는 순간)
    //사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
}
