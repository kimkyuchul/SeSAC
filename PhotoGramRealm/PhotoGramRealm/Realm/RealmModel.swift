//
//  RealmModel.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/04.
//

import Foundation
import RealmSwift

class DiaryTable: Object {
    
    // primaryKey키 설정
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var diaryTitle: String // 일기 제목(필수)
    @Persisted var diaryDate: Date // 일기 등록 날짜(필수)
    @Persisted var diaryContents: String? // 일기 내용 (옵션)
    @Persisted var diaryPhoto: String? // 일기 사진 URL (옵션)
    @Persisted var diaryLike: Bool
    
    convenience init(diaryTitle: String, diaryDate: Date, diaryContents: String? = nil, diaryPhoto: String? = nil) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.diaryDate = diaryDate
        self.diaryContents = diaryContents
        self.diaryPhoto = diaryPhoto
        self.diaryLike = false
    }
}

