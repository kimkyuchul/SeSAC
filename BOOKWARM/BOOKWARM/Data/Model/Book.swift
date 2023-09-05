//
//  Book.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/09.
//

import Foundation

struct Book {
    let isbn: String
    let title: String
    let price: Int
    let thumbnail: String
    
    init(isbn: String, title: String, price: Int, thumbnail: String) {
        self.isbn = isbn
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }
    
    var imagePath: String {
        return "\(isbn).jpg"
    }
}
