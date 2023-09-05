//
//  DetailViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import Foundation
import RealmSwift

enum TransitionType {
    case add
    case edit
}

protocol DetailInput: AnyObject {
    func viewWillAppear()
}
protocol DetailOutput: AnyObject {
    var binding: (() -> Void)? { get }
}

class DetailViewModel: DetailInput, DetailOutput {
    
    var BookList: BookRealmModel?
    var movie: Movie?
    var binding: (() -> Void)?
    
    var textCount: Int?
    
    var navigation: TransitionType = .add
    
    func viewWillAppear() {
        binding?()
    }
    
    func updateBookData(text: String) {
        RealmManager.shared.updateBook(BookList ?? BookRealmModel(), text: text) { result in
            switch result {
            case .success( _):
                print("succes")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteBookData() {
        RealmManager.shared.deleteBook(BookList ?? BookRealmModel()) { result in
            switch result {
            case .success( _):
                print("succes")
            case .failure(let error):
                print(error)
            }
        }
    }
}


