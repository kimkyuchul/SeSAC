//
//  ContentView.swift
//  SeSACTest
//
//  Created by 김규철 on 2023/12/08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var emailText = ""
    @State private var idText = ""
    @State private var passwordText = ""
    @State private var showPage = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            TextField("이메일을 입력", text: $emailText)
                .font(.title)
                .foregroundColor(.green)
                .accessibilityIdentifier("emailTextField")
                .accessibilityLabel("이메일 기입란")
            TextField("아이디를 입력", text: $idText)
                .accessibilityIdentifier("idTextField")
            TextField("비밀번호를 입력", text: $passwordText)
                .accessibilityIdentifier("passwordTextField")
            Button("로그인 하기") {
                showPage = true
            }
            .accessibilityIdentifier("loginButton")
        }
        .padding()
        .sheet(isPresented: $showPage, content: {
            NextView()
        })
//        .onAppear {
//            NetworkManager.shared.fetchLotto { response in
//                print(response)
//            }
//        }
    }
}

struct NextView: View {
    
    var body: some View {
        Text("다음페이지")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
