//
//  MovieListViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import Foundation

import RealmSwift


protocol MovieListInput: AnyObject {
    func viewWillAppear()
}
protocol MovieListOutput: AnyObject {
    func getMovieList()
}

class MovieListViewModel: MovieListInput, MovieListOutput {
    
    var tasks: Results<BookRealmModel>!
    
    /// 검색 모드 or 일반 모드 분기
    var isFiltering = false
    
    var movie = [Movie]()
    var getDataObservar: (() -> Void)?
    
    /// 검색 시 데이터
    var searchList: [Movie] = []
    
    /// 검색 리스트
    var searchData: [String] {
        return movie.map { $0.title }
    }
    
    
    func viewWillAppear() {
        getBookRealmData()
    }
    
    /// likeButton 선택 시
    func likeButtonTapped(indexPath: IndexPath) {
        if self.isFiltering {
            var searchListindex = searchList[indexPath.row]
            searchListindex.like.toggle()
            
            if let movieIndex = movie.firstIndex(where: { $0.title == searchListindex.title }) {
                movie[movieIndex] = searchListindex
                searchList[indexPath.row].like.toggle()
            }
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
        self.getDataObservar?()
    }
    
    func getBookRealmData() {
        let data = RealmManager.shared.readBook(BookRealmModel.self)
        tasks = data.sorted(byKeyPath: "price", ascending: false)
        
        self.getDataObservar?()
    }
}
