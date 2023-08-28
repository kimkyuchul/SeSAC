//
//  AddViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

final class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 x
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print("selectImageNotificationObserver")
        // Value of optional type '[AnyHashable : Any]?' must be unwrapped to refer to member 'subscript' of wrapped base type '[AnyHashable : Any]'
        // 딕셔너리 키에 값이 없으면 어떻하지? => 옵셔널 형태로 나오는 이유
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])
        
        /*
         func controlTextDidChange(_ notification: Notification) {
             if let fieldEditor = notification.userInfo?["NSFieldEditor"] as? NSText,
                 let postingObject = notification.object as? NSControl {
                 // work with the field editor and posting object
             }
         }
         */
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
        
    }
    
    @objc func searchButtonClicked() {
        
        let word = ["apple", "banana", "cake"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        present(SearchViewController(), animated: true)
    }

    override func configureView() {
        super.configureView()
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        }
    
    override func setConstraints() {
    }
}

