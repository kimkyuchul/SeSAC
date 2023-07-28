//
//  Bundle+.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit

extension Bundle {
    // 생성한 .plist 파일 경로 불러오기
    var MOVIE_API_KEY: String {
        guard let file = self.path(forResource: "Movie", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["API_KEY"] as? String else {
            fatalError("API_KEY error")
        }
        return key
    }
}
