//
//  Movie.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import Foundation

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: String
    let Poster: String
}

struct MovieListResponse: Codable {
    let Search: [Movie]
    let totalResults: String
    let Response: String
}
