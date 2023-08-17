//
//  KaKaoVideo.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/17.
//

import Foundation

struct KaKaoVideo: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let playTime: Int
    let thumbnail: String
    let url: String
    let author, title, datetime: String

    enum CodingKeys: String, CodingKey {
        case playTime = "play_time"
        case thumbnail, url, author, title, datetime
    }
}

// MARK: - M
struct M: Codable {
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let totalCount, pageableCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
    }
}
