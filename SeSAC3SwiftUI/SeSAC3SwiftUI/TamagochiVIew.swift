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
    @State private var inOn = false
    @State private var text = "하이"
    
    var body: some View {
        VStack {
            TextField("밥알 갯수 입력하기", text: $text)
                .padding()
            Toggle("스위치", isOn: $inOn)
                .padding()
            TamagochiTextView(title: "밥알", count: $riceCount)
            Button("밥알 갯수") {
                riceCount += 1
                inOn.toggle()
            }
            .padding(50) // 타이틀 영역만 클릭이 된다. padding은 선택 X
            .background(.pink)
            
            TamagochiTextView(title: "물", count: $waterCount)
            Button {
                waterCount += 1
                text = "\(waterCount)"
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
        .padding() // 모든뷰에 적용
    }
}

struct TamagochiTextView: View {
    let title: String
//    @Binding var count: Int
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text("\(title)의 갯수 \(count)")
                .background(.black)
                .foregroundColor(.white)
                .font(.title)
            Button("하위뷰 버튼") {
                // 여기서도 Count +1이 되어야 한다.
//                count += 1 // body는 mutating하지 않음
                count += 1
            }
        }
    }
}

struct TamagochiVIew_Previews: PreviewProvider {
    static var previews: some View {
        TamagochiVIew()
    }
}
