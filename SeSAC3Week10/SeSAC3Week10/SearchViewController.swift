//
//  SearchViewController.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/21.
//

import UIKit
/// 세로 스크롤 뷰
//final class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//    let contentView = UIView()
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = . white
//        configureHierarchy()
//        configureLayout()
//        configureContentView()
//    }
//
//    func configureContentView() {
//        [imageView, label, button].forEach {
//            scrollView.addSubview($0)
//        }
//
//        imageView.backgroundColor = .orange
//        button.backgroundColor = .magenta
//        label.backgroundColor = .systemGray
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        label.text = "aadasdsadadadadadad\naadasdadadadad\nasdadsad\nasdadadasdsad\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsd"
//        label.numberOfLines = 0
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//
//    func configureHierarchy() {
//        scrollView.backgroundColor = .blue
//        view.addSubview(scrollView)
//        contentView.backgroundColor = .purple
//        scrollView.addSubview(contentView)
//    }
//
//    func configureLayout() {
//        scrollView.bounces = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//
//        // scrollView.contentLayoutGuide
//        contentView.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(scrollView)
//            make.width.equalTo(scrollView.snp.width)
//        }
//    }

    
    
    
/// 가로스크롤
    
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//    func configureLayout() {
//        scrollView.backgroundColor = .brown
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.backgroundColor = .systemPink
//        stackView.spacing = 15
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(scrollView.snp.height)
//        }
//    }
//
//    func configureStackView() {
//        let label2 = (1...5).map { _ in
//            makeLabel()
//        }
//
//        label2.forEach { label in
//            stackView.addArrangedSubview(label)
//        }
//    }
//
//    func makeLabel() -> UILabel {
//        let label1 = UILabel()
//        label1.text = "안녕하세여 안녕하세여 안녕하세여 안녕하세여"
//        label1.textColor = .cyan
//        return label1
//    }
// }
