//
//  SampleViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import Foundation

class SampleViewModel {
    
    var list = [User(name: "kyuchul", age: 23), User(name: "hue", age: 23), User(name: "jack", age: 60)]
    
    var numberOfRowsInSection: Int {
        list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return list[indexPath.row]
    }
}
