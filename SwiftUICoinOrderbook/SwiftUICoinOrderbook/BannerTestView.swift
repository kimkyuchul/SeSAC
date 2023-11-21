//
//  BannerTestView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/21.
//

import SwiftUI

struct BannerTestView: View {
    
    @Binding var testNumber: Int
    
    var body: some View {
        VStack {
            Text("테슷흐: \(testNumber)")
            Button("숫자 업데이트") {
                testNumber = Int.random(in: 1...100)
            }
        }
    }
}

struct BannerTestView_Previews: PreviewProvider {
    static var previews: some View {
        BannerTestView(testNumber: .constant(5))
    }
}
