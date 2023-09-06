//
//  AppDelegate.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            
            // 단순 컬럼 추가 삭제는 별도 코드가 필요 없다.
            if oldSchemaVersion < 1 {
                // Add subTitle 컬럼
            }
            
            if oldSchemaVersion < 2 {
                
                // 컬럼 이름 변경
                migration.renameProperty(onType: BookRealmModel.className(), from: "overview", to: "overView")
            }
            
            if oldSchemaVersion < 3 {
                
                // 기존 컬럼의 기본값, 타입, 컬럼 결합 등
                migration.enumerateObjects(ofType: BookRealmModel.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["comment"] = "\(old["title"]!) 이 영화 한번 봐보세요."
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

