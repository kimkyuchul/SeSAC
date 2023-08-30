//
//  NetworkError.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/31.
//

import Foundation

enum NetworkError: Error {
    case configureHTTPError(code: Int)
    case unknownError
    case urlSessionError(Error)
    case emptyDataError
}
