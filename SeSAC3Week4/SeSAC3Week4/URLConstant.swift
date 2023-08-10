//
//  URLConstant.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/10.
//

import Foundation

import Alamofire

enum URLConstant {
    static let detectLangs = "https://openapi.naver.com/v1/papago/detectLangs"
    static let papago = "https://openapi.naver.com/v1/papago/n2mt"
}

enum DefaultHearder {
    static let hearder: HTTPHeaders = [
        "X-Naver-Client-Id": APIKey.naverID,
        "X-Naver-Client-Secret": APIKey.naverSecret
    ]
}
