//
//  BookRealmModel.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var price: Int
    @Persisted var thumbnail: String
    @Persisted var overview: String?
    
    convenience init(title: String, price: Int, thumbnail: String, overview: String?) {
        self.init()
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
        self.overview = overview
    }
}



