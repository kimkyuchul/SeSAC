//
//  RealmManager.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/09/05.
//

import Foundation

import RealmSwift
import UIKit

final class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    private let localRealm = try! Realm()
    
    func readBook(_ object: BookRealmModel.Type) -> Results<BookRealmModel> {
        return localRealm.objects(object)
    }
    
    func writeBook(_ object: BookRealmModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        do {
            try localRealm.write {
                localRealm.add(object)
                completion(.success(true))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateBook(_ object: BookRealmModel, text: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        if let data = localRealm.object(ofType: BookRealmModel.self, forPrimaryKey: object._id) {
            do {
                try localRealm.write {
                    data.overview = text
                    completion(.success(true))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func deleteBook(_ object: BookRealmModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        do {
            try localRealm.write {
                localRealm.delete(object)
                completion(.success(true))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
