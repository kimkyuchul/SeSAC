//
//  DetailViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import Foundation

protocol DetailInput: AnyObject {
    func viewWillAppear()
}
protocol DetailOutput: AnyObject {
    var binding: (() -> Void)? { get }
}

class DetailViewModel: DetailInput, DetailOutput {

    var movie: Movie?
    var binding: (() -> Void)?
    
    func viewWillAppear() {
        binding?()
    }
}
