//
//  JackPhoto.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/09/01.
//

import Foundation
// 쓸것만 발라내서 쓰자.
struct JackPhoto: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
