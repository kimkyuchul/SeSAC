//
//  WordViewModel.swift
//  CoinedWord
//
//  Created by 김규철 on 2023/07/24.
//

import Foundation

class WordViewModel {
        
    private let wordModel: [JejuWord] = [
        JejuWord(word: [
            "밥먹언?":"밥먹었냐고 물어보는 제주도 방언입니다"]),
        JejuWord(word: [
            "버치다":"\"힘들다\" 라는 제주도 방언입니다."]),
        JejuWord(word: [
            "무사":"\"왜\" 라는 제주도 방언입니다."]),
        JejuWord(word: [
            "하르방": "\"할아버지\" 라는 제주도 방언입니다."]),
        JejuWord(word: [
            "호꼼": "\"조금\" 이라는 제주도 방언입니다."]),
        JejuWord(word: [
            "물애기" : "\"애기\" 라는 제주도 방언입니다."]),
        JejuWord(word: [
            "감저" : "\"고구마\" 라는 제주도 방언"])
    ]
    
    func getRandomWord() -> String {
        guard let randomJejuWordModel = wordModel.randomElement()?.word else { return "" }
        guard let randomWord = randomJejuWordModel.keys.randomElement() else { return "" }
        return randomWord
    }
    
    func getWordData() -> [String:String] {
        var jejuWordData: [String: String] = [:]
         for jejuWord in wordModel {
             for (key, value) in jejuWord.word {
                 jejuWordData[key] = value
             }
         }
         return jejuWordData
    }
}

