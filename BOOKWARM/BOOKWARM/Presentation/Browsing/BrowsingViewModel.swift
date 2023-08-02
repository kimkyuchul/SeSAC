//
//  BrowsingViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/03.
//

import Foundation

protocol BrowsingInput: AnyObject {
    func viewWillAppear()
}
protocol BrowsingOutput: AnyObject {
    func getMovieList()
}

class BrowsingViewModel: BrowsingInput, BrowsingOutput {
    
    var movie = [Movie]()
    var binding: (() -> Void)?
    
    func viewWillAppear() {
        getMovieList()
    }
}

extension BrowsingViewModel {
    
    func getMovieList() {
        self.movie = MovieInfo().movie
        self.binding?()
    }
}
