//
//  DetailViewController.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/05.
//

import UIKit

import RealmSwift

final class DetailViewController: BaseViewController {
    
    let titleTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    let contentsTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "날짜를 입력해주세요"
        return view
    }()
    
    var data: DiaryTable?
    
//    let realm = try! Realm()
    
    let repository = DiaryTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        titleTextField.textColor = .white
        contentsTextField.textColor = .white
        print(data?.diaryTitle)
        
    }
    
    override func configure() {
        [titleTextField, contentsTextField].forEach { view in
            self.view.addSubview(view)
        }
        
        titleTextField.text = data?.diaryTitle
        contentsTextField.text = data?.contents
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonClicked))
    }
    
    @objc func editButtonClicked() {
        
        guard let data = data else { return }
        
//        let item = DiaryTable(value: ["_id":data?._id, "diaryTitle":titleTextField.text!, "diaryContents":contentsTextField.text!])
        
//        do {
//            try realm.write {
//                realm.add(item, update: .modified)
//            }
//        } catch {
//            print(error)
//        }
        
//        do {
//            try realm.write {
//                realm.create(DiaryTable.self, value: ["_id":data?._id, "diaryTitle":titleTextField.text!, "diaryContents":contentsTextField.text!], update: .modified)
//            }
//        } catch {
//            print(error)
//        }
        
        repository.updateDiaryPhotoItem(id: data._id, title: titleTextField.text!, contents: contentsTextField.text!)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        contentsTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(titleTextField).offset(60)
        }
    }
}
