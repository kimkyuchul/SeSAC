//
//  String+.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/09/06.
//

import UIKit

extension String {
    func trimmingWhitespace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
