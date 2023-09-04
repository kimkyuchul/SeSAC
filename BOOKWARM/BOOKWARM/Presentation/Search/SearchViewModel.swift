//
//  SearchViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/09.
//

import Foundation

import Alamofire
import SwiftyJSON
import RealmSwift

enum ViewState {
    case isActive
    case isLoding
}

protocol bookSearchInput: AnyObject {
    func viewWillAppear()
}
protocol bookSearchOutput: AnyObject {
    func getBookData(page: Int)
}

class SearchViewModel: bookSearchInput, bookSearchOutput {
    
    let localRealm = try! Realm()
    
    var query: String?
    var BookList: [Book] = []
    
    var isEnd = false
    var currentPage: Int = 1
    var viewState = ViewState.isActive
    
    var getBookObservar: (() -> Void)?
    
    func viewWillAppear() {
        getBookData(page: currentPage)
    }
}

extension SearchViewModel {
    func getBookData(page: Int) {
        
        guard viewState == .isActive else { return }
        viewState = .isLoding
        
        guard let query = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=10&page=\(page)"
        let header: HTTPHeaders = ["Authorization":"KakaoAK \(APIKey.key)"]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...399).responseJSON { response in
            
            self.viewState = .isActive
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let isEnd = json["meta"]["is_end"].boolValue
                self.isEnd = isEnd
                
                let book = json["documents"].arrayValue
                    .map {
                        Book(
                            title: $0["title"].stringValue,
                            price: $0["price"].intValue,
                            thumbnail: $0["thumbnail"].stringValue
                        )
                    }
                

                self.BookList.append(contentsOf: book)
                self.currentPage += 1
                self.getBookObservar?()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveBookdata(indexPath: IndexPath, book: [Book]) {
        
        let bookdata = book[indexPath.row]
        
        let data = BookRealmModel(title: bookdata.title, price: bookdata.price, thumbnail: bookdata.thumbnail)
        
        try! localRealm.write {
            localRealm.add(data)
            print("add")
        }
    }
}
