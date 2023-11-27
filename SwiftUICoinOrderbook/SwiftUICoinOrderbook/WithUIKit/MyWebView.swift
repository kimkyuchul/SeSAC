//
//  MyWebView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/27.
//

import SwiftUI

import WebKit

// SwiftUI에서 UIKit을 사용하는 법 -> UIViewRePresentable

struct MyWebView: UIViewRepresentable {
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

    }
}
