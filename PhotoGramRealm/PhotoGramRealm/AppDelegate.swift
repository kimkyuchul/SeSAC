//
//  AppDelegate.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 4) { migration, oldSchemaVersion in
            
            // oldSchemaVersion -> 현재 버전
            if oldSchemaVersion < 1 { } // diaryPin Column 추가
            
            if oldSchemaVersion < 2 { } // diaryPin Column 삭제
            
            if oldSchemaVersion < 3 {
                
                // 기존의 diaryPhoto를 photo로 rename
                // renameProperty 붙이지 않고 버전만 변경 시 시존 diaryPhoto의 데이터는 날라간다.
                migration.renameProperty(onType: DiaryTable.className(), from: "diaryPhoto", to: "photo")
                
            } // diaryPhoto -> photo Column 이름 변경
            
            // 기존 데이터를 유지하고 싶다면 renameProperty를 꼭 붙여야 한다. -> 붙이지 않고 컬럼명 수정 후 스키마 올리면 해당 데이터 모두 Null이 된다.
            if oldSchemaVersion < 4 { } // diaryContents -> contents 컬럼명 수정
            
            if oldSchemaVersion < 5 { // diarySummary 컬럼 추가, title + contents 합쳐서 넣기
                
                migration.enumerateObjects(ofType: DiaryTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                
                    new["diarySummary"] = "제목은 '\(old["diaryTitle"])'이고, 내용은 '\(old["diaryContents"])' 입니다."
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

