//
//  WebViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
//    var webView: WKWebView!
    
    var webView: WKWebView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "이건 웹뷰다"
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(20)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        reloadButtonClicked()
        goBackButtonClicked()
        goForwardButtonClicked()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemPink
        navigationController?.navigationBar.isTranslucent = false
        // 스크롤 시 
        navigationController?.navigationBar.standardAppearance = appearance // 스크롤 시 색상 변경
        // 스크롤을 하고 있지 않은 상태
        navigationController?.navigationBar.scrollEdgeAppearance = appearance // 기존에 색상 변경되었다가 스크롤 시 색상 없어짐
        
        // 탭 시 혹은 페이징, 스크롤 시 네비바, 탭바를 숨기고 싶다면
        navigationController?.hidesBarsOnTap = true
    }
    
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
