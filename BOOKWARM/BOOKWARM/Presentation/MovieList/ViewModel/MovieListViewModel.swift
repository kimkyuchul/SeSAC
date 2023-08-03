//
//  MovieListViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import Foundation


protocol MovieListInput: AnyObject {
    func viewWillAppear()
}
protocol MovieListOutput: AnyObject {
    func getMovieList()
}

class MovieListViewModel: MovieListInput, MovieListOutput {
    
    /// 검색 모드 or 일반 모드 분기
    var isFiltering = false
    
    var movie = [Movie]()
    var getMovieObservar: (() -> Void)?
    
    /// 검색 시 데이터
    var searchList: [Movie] = []
    
    /// 검색 리스트
    var searchData: [String] {
        return movie.map { $0.title }
    }
    
    
    func viewWillAppear() {
        getMovieList()
    }
    
    /// likeButton 선택 시
    func likeButtonTapped(indexPath: IndexPath) {
        if self.isFiltering {
            self.searchList[indexPath.row].like.toggle()
        } else {
            self.movie[indexPath.row].like.toggle()
        }
    }
    
    /// 검색
    func searchText(text: String) {
        searchList = text.isEmpty ? movie : movie.filter { $0.title.contains(text) }
    }
}

extension MovieListViewModel {
    
    func getMovieList() {
        self.movie = MovieInfo().movie
        self.getMovieObservar?()
    }
}
