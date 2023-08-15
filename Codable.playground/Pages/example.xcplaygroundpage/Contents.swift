import UIKit

var greeting = "Hello, playground"

let json = """
  {
    "quote": "The will of man is his happiness.",
    "author": "Friedrich Schiller",
    "category": "happiness"
  }
"""

//String -> Data -> Quote (디코딩, 역직렬화)
//키 값이 같아야 함
// 옵셔널 처리 시 실패(DecodingError) 뜨지 않고 nil로 오게됨!
struct Quote: Decodable {
    let quote: String?
    let author: String?
    let category: String?
}

//String -> Data
guard let result = json.data(using: .utf8) else {
    fatalError("Error")
}

print(result)
//dump(result)


//Data -> Quote
//An object that decodes instances of a data type from JSON objects.
// Error Handling, Do try Catch, Meta Type
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.quote)
} catch {
    print(error)
}

