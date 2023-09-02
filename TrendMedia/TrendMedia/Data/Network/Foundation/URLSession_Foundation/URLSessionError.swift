//
//  URLSessionError.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/09/02.
//

import Foundation

enum URLSessionError: Error {
    case configureHTTPError(code: Int)
    case unknownError
    case urlSessionError(Error)
    case emptyDataError
}
