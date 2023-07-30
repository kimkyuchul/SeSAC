//
//  MovieViewModel.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/30.
//

import Foundation

protocol Input: AnyObject {
    func viewWillAppear()
}

protocol Output: AnyObject {
    func getMovieList()
}

class MovieViewModel: Input, Output {
    
    var setUpContents: (() -> Void)?
    var movieData: [Movie]?
    
    func viewWillAppear() {
        getMovieList()
    }
}

extension MovieViewModel {
     func getMovieList() {
        URLSessionService.shard.getMovieList(page: 5) { [weak self] result in
            self?.movieData = result.Search
            self?.setUpContents?()
        }
    }
}
