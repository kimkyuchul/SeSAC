//
//  DiaryTableRepository.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/06.
//

import Foundation
import RealmSwift

protocol DiaryTableRepositoryType: AnyObject {
    func fetch<T: Object>(_ object: T.Type) -> Results<T>
    func fetchDiaryPhotoFilter() -> Results<DiaryTable>
    func createItem<T: Object>(_ object: T)
    func updateDiaryPhotoItem(id: ObjectId, title: String, contents: String)
}

final class DiaryTableRepository: DiaryTableRepositoryType {
    
    private let realm = try! Realm()
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func fetch<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(object).sorted(byKeyPath: "diaryTitle", ascending: true)
    }
    
    func fetchDiaryPhotoFilter() -> Results<DiaryTable> {
        
        let result = realm.objects(DiaryTable.self).where {
            //3. 사진이 있는 데이터만 불러오기 nil 여부 판단
            $0.photo != nil
            
        }
        
        return result
    }
    
    func createItem<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func updateDiaryPhotoItem(id: ObjectId, title: String, contents: String) {
        do {
            try realm.write {
                realm.create(DiaryTable.self, value: ["_id":id, "diaryTitle":title, "diaryContents":contents], update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
