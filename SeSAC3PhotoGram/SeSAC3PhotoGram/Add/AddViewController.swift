//
//  AddViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit
import seSACFramework

// protocol 값 전달 1
protocol PassDataProtocol: AnyObject {
    func receiveDate(date: Date)
}

protocol PassImageProtocol: AnyObject {
    func receiveImage(ImageString: String)
}

final class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 x
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ClassOpenExample.publicExample()
//        ClassPublicExample.publicExample()
//        ClassPublicExample.internalExample()
//        ClassInternalExample
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name.selectImage, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.selectImage, object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print(#function)
        // Value of optional type '[AnyHashable : Any]?' must be unwrapped to refer to member 'subscript' of wrapped base type '[AnyHashable : Any]'
        // 딕셔너리 키에 값이 없으면 어떡하지? => 옵셔널 형태로 나오는 이유
//        print(notification.userInfo?["name"])
//        print(notification.userInfo?["sample"])
        
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
        
//        present(SearchViewController(), animated: true)
        navigationController?.pushViewController(SearchViewController(), animated: true)
        
    }
    
    @objc func dateButtonClicked() {
        let vc = DateViewController()
        // protocol 값 전달 5
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        vc.completionHandler = { [weak self] text, age, push in
            self?.mainView.titleButton.setTitle(text, for: .normal)
            print("cp", age, push)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func closureButtonClicked() {
        let vc = TitleViewController()
        vc.textviewCompletionHandler = { [weak self] text in
            self?.mainView.closureButton.setTitle(text, for: .normal)
        }
        present(vc, animated: true)
    }

    override func configureView() {
        super.configureView()
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.closureButton.addTarget(self, action: #selector(closureButtonClicked), for: .touchUpInside)
        }
}

// protocol 값 전달 4
extension AddViewController: PassDataProtocol, PassImageProtocol {
    func receiveImage(ImageString: String) {
        mainView.photoImageView.image = UIImage(systemName: ImageString)
    }
    
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

