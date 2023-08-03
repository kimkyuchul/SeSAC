//
//  DetailViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import Foundation

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

    var movie: Movie?
    var binding: (() -> Void)?
    
    var textCount: Int?
    
    var navigation: TransitionType = .add
    
    func viewWillAppear() {
        binding?()
    }
}
