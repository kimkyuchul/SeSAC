//
//  NewSimpleViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/18.
//

import Foundation

class NewSimpleViewModel {
    
    let list: Observable<[User]> = Observable([])
    
    var list2 = [User(name: "뷸쌍", age: 23), User(name: "감자", age: 63), User(name: "정말", age: 33)]
    
    
    
    func append() {
        list.value =  [User(name: "kyuchul", age: 23), User(name: "kyuchul", age: 23), User(name: "jack", age: 60)]
    }
    
    func remove() {
        list.value = []
    }
    
    func removeUser(idx: Int) {
        list.value.remove(at: idx)
    }
    
    func insertUser(name: String) {
        let value = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(value, at: Int.random(in: 0...2))
    }
}
