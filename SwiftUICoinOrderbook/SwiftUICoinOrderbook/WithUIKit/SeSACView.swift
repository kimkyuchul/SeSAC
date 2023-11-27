//
//  SeSACView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/27.
//

import SwiftUI

struct SeSACView: View {
    
    @State private var textFieldText = "SwiftUI 텍스트"
    
    @State private var uiKitTextFieldText = "Swift 텍스트"
    
    var body: some View {
        VStack {
            Text(textFieldText)
            TextField("SwiftUI 텍스트필드", text: $textFieldText)
            MyTextField(text: $uiKitTextFieldText)
            MyWebView(url: "https://www.apple.com")
                .frame(width: 300, height: 400)
        }
    }
}

struct SeSACView_Previews: PreviewProvider {
    static var previews: some View {
        SeSACView()
    }
}
