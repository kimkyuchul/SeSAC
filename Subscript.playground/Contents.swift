import UIKit

var greeting = "Hello, playground"

// 스트링 구조에서는 서브스크립트가 존재하지 않는다.
greeting.count

greeting[2]


extension String {
    
    subscript(idx: Int) -> String? {
        
        // 인덱스 범주
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}

var number = [1,2,3]

//number[10] // 런타임 오류

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


number[safe: 10]
