//
//  SearchViewModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/09.
//

import Foundation

import Alamofire
import SwiftyJSON

protocol bookSearchInput: AnyObject {
    func viewWillAppear()
}
protocol bookSearchOutput: AnyObject {
    func getBookData()
}

class SearchViewModel: bookSearchInput, bookSearchOutput {

    var query: String?
    var BookList: [Book] = []
    
    var getBookObservar: (() -> Void)?
    
    func viewWillAppear() {
        getBookData()
    }
}

extension SearchViewModel {
    func getBookData() {
        guard let query = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        let header: HTTPHeaders = ["Authorization":"KakaoAK \(APIKey.key)"]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...399).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let book = json["documents"].arrayValue
                    .map {
                        Book(
                            title: $0["title"].stringValue,
                            price: $0["price"].intValue,
                            thumbnail: $0["thumbnail"].stringValue
                        )
                    }
                
                print(book)
                
                self.BookList = book
                self.getBookObservar?()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
