//
//  MovieListViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import Foundation

protocol Input: AnyObject {
    func viewDidLoad()
}
protocol Output: AnyObject {
    func getMovieList()
}

class MovieListViewModel: Input, Output {
    
    var movie = [Movie]()
    var getMovieObservar: (() -> Void)?
    
    func viewDidLoad() {
        getMovieList()
    }
}

extension MovieListViewModel {
    
    func getMovieList() {
        self.movie = MovieInfo().movie
        self.getMovieObservar?()
    }
}
