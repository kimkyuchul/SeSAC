import UIKit

var greeting = "Hello, playground"

let json = """
  {
    "quote_content": "The will of man is his happiness.",
    "author_name": "Friedrich Schiller",
    "likelike": "34567"
  }
"""

//String -> Data -> Quote (디코딩, 역직렬화)
//키 값이 같아야 함
// 옵셔널 처리 시 실패(DecodingError) 뜨지 않고 nil로 오게됨!
struct Quote: Decodable {
    let content: String
    let name: String
    let like: Int
    
    enum CodingKeys: String, CodingKey {
        case content = "quote_content"
        case name = "author_name"
        case like = "likelike"
    }
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

let decoder = JSONDecoder()
// 키의 디코딩 전략을 SnakeCase로 설정
//decoder.keyDecodingStrategy = .convertFromSnakeCase

do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
    print(value.content)
} catch {
    print(error)
}


