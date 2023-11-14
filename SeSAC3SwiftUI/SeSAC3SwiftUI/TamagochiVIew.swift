//
//  TamagochiVIew.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/14.
//

import SwiftUI

struct user {
    var nickname = "김규철"
    
    var introduce: String {
        mutating get {
            nickname = "kkk"
            return "하이 \(nickname)"
        }
    }
    
    mutating func changeNickname() {
        nickname = "kkk"
    }
}

// @State. Source of Truth. View에 대한 상태를 저장하기 위한 목적
struct TamagochiVIew: View {
    
    // UI는 Data에 의존해서 자신의 상태를 결정
    @State private var riceCount = 0
    @State private var waterCount = 0
    
    var body: some View {
        VStack {
            TamagochiTextView(title: "밥알", count: $riceCount)
            Button("밥알 갯수") {
                riceCount += 1
            }
            .padding(50) // 타이틀 영역만 클릭이 된다. padding은 선택 X
            .background(.pink)
            
            TamagochiTextView(title: "물", count: $waterCount)
            Button {
                waterCount += 1
            } label: {
                HStack {
                    Text("물 줘요.")
                        .font(.title3)
                    Image(systemName: "plus")
                }
                .padding(50)
                .background(.green)
            }
        }
    }
}

struct TamagochiTextView: View {
    let title: String
    @Binding var count: Int
    
    var body: some View {
        Text("\(title)의 갯수 \(count)")
            .background(.black)
            .foregroundColor(.white)
            .font(.title)
    }
}

struct TamagochiVIew_Previews: PreviewProvider {
    static var previews: some View {
        TamagochiVIew()
    }
}
