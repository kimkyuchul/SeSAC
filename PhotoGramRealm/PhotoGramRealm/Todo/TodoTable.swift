//
//  TodoTable.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/08.
//

import Foundation
import RealmSwift

class toDoTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var favorite: Bool
    
    // To Many Relationship 1대 다 관계
    // 테이블이 또 다른 테이블을 가지고 있는 형태
    @Persisted var detail: List<DetailTable>
    
    // To One Relationship: EmbeddedObject(무조건 옵셔널 필수다.), 별도의 테이블이 생성되는 형태는 아님
    @Persisted var memo: Memo?
    
    convenience init(title: String, favorite: Bool) {
        self.init()
        
        self.title = title
        self.favorite = favorite
    }
}

class DetailTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var detail: String
    @Persisted var deadline: Date
    
    // 역관계
    //Inverse Relationship Property (LinkingObjects)
    // 디테일의 입장에서 나의 상위 테이블이 누구?
    // 상위에서  @Persisted var detail: List<DetailTable>로 연결되어 있을 때 사용이 가능하다.
    // 상위테이블에서  @Persisted var detail: List<DetailTable>로 정의했기 떄문에 -> originProperty에 "detail"이라는 값이 들어가게된다.
    @Persisted(originProperty: "detail") var mainTodo: LinkingObjects<toDoTable>
    
    convenience init(detail: String, deadline: Date) {
        self.init()
        
        self.detail = detail
        self.deadline = deadline
    }
}

// 1대 1 관계
// 하나의 컬럼 단위로 사용
class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var date: Date
}
