//
//  PointBackgroundText.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

// ViewModifier: Custom Modifier를 생성할 수 있도록 도와주는 프로토콜
// private 중요 -> extension View로 사용가능하기 때문
private struct PointBackgroundText: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(10)
            .foregroundStyle(.white)
            .background(.pink)
//            .clipShape(.capsule)
    }
}

extension View {
    func asPointBackgroundText() -> some View {
        modifier(PointBackgroundText())
    }
}
