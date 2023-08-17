//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by 김규철 on 2023/08/16.
//

import UIKit

import Alamofire


// 컴파일 시 오류 타입 알 수 있음
// enum은 컴파일 시 확인되기 때문
enum ValidationError: Int, Error {
    case emptyString = 404
    case isNotInt = 401
    case isNotDate = 500
}

class CodableViewController: UIViewController {
    
    var resultText = "Apple"

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchLottoData()
//        fetchTranslateData(source: "ko", target: "en", text: "안녕")
        
        WeatherManager.shared.callRequestString { [weak self] temp, humidity in
            self?.tempLabel.text = temp
            self?.humidityLabel.text = humidity
        }
        
        WeatherManager.shared.callRequestCodable { result in
            switch result {
            case .success(let value):
                self.tempLabel.text = "\(value.main.temp)"
            case .failure(let error):
                print(error)
            }
        }

    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        guard let text = dateTextField.text else { return }
        
        
        // 조건문이라기보단 디코딩 실패 성공 등을 확인할 때
        do {
            let result = try validateUserInputError(text: text)
            
        } catch {
            print(ValidationError.emptyString.rawValue)
        }
        
//        if validateUserInput(text: text) {
//            print("검색 가능")
//        } else {
//            print("검색 불가")
//        }
        
        
    }
    
    func validateUserInputError(text: String) throws -> Bool {
        // 빈 칸일 경우
        guard !text.isEmpty else {
            print("빈 값")
            throw ValidationError.emptyString
        }
        
        guard Int(text) != nil else {
            print("숫자 아님")
            throw ValidationError.isNotInt
        }
        
        //날짜 형식으로 반환이 되는 지
        guard checkDateFormat(text: text) else {
            print("형식 안맞음")
            throw ValidationError.isNotDate
        }
        
        return true
    }
    
    // 로직이 있는 경우는 조건문으로 처리 하지만 디코딩 실패, 다운로드 실패와 같은 오류가 있을 때 do try catch 사용
    func validateUserInput(text: String) -> Bool {
        // 빈 칸일 경우
        guard !text.isEmpty else {
            print("빈 값")
            return false
        }
        
        guard Int(text) != nil else {
            print("숫자 아님")
            return false
        }
        
        //날짜 형식으로 반환이 되는 지
        guard checkDateFormat(text: text) else {
            print("형식 안맞음")
            return false
        }
        
        return true
    }
    
    func checkDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let result = format.date(from: text)
        
        return result == nil ? false: true
    }
    
    func fetchTranslateData(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.clientID,
            "X-Naver-Client-Secret": Key.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                
                // 무한루프
//                self.fetchTranslateData(source: String, target: String, text: String)
                
                self.fetchTranslate(source: "en", target: "ko", text: self.resultText)
            }

    }
    
    func fetchTranslate(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.clientID,
            "X-Naver-Client-Secret": Key.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                
                print("최종확인", self.resultText)
            }

    }

    
//    func fetchLottoData() {
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
//        // 요청의 순서에 대한 보장이 없다 -> global Queue
//
//
//        // 1
//        AF.request(url, method: .get).validate()
//            .responseData { response in
//                guard let value = response.value else { return }
//                print("responseData:", value)
//            }
//
//        // 2
//        AF.request(url, method: .get).validate()
//            .responseString { response in
//                guard let value = response.value else { return }
//                print("responseString:", value)
//            }
//
//        // 3
//        AF.request(url, method: .get).validate()
//            .response { response in
//                guard let value = response.value else { return }
//                print("response:", value)
//            }
//
//        AF.request(url, method: .get).validate()
//            .responseDecodable(of: Lotto.self) { response in
//                guard let value = response.value else { return }
//                print("responseDecodable:", value)
//            }
//
//    }


}

struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}
