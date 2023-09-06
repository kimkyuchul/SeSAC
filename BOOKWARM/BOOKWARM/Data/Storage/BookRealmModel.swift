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
    @Persisted var overView: String?
    @Persisted var subTitle: String
    @Persisted var comment: String
    
    convenience init(title: String, price: Int, thumbnail: String, overView: String?, subTitle: String) {
        self.init()
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
        self.overView = overView
        self.subTitle = subTitle
        self.comment = "\(title) 이 영화 한번 봐보세요."
    }
}



