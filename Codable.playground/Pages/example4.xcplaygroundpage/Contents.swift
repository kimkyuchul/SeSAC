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
    let isInfluencer: Bool // 좋아요 3만개 이상
    
    enum CodingKeys: String, CodingKey {
        case content = "quote_content"
        case name = "author_name"
        case like = "likelike"
    }
    
    // 디코딩을 하면서 구조체에 담을 때 수동으로
    // 초기화 할 때 프로퍼티에 내용을 담아달라
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decode(String.self, forKey: .content)
        like = try container.decode(Int.self, forKey: .like)
        // 서버에 데이터는 없지만 like 기반으로 담을 수 잇다.
        isInfluencer = (30000...).contains(like) ? true : false
        // decodeIfPresent => 옵셔널 타입일 때 사용
        name = try! container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
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


