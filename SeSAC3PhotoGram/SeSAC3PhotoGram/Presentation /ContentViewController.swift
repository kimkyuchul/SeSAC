//
//  ContentViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/31.
//

import UIKit

class ContentViewController: BaseViewController {
    
    let textView = {
        let v = UITextView()
        v.textColor = .black
        v.backgroundColor = .systemPink
        return v
    }()
    
    let sampleView = {
        let v = UIView()
        v.backgroundColor = .yellow
        return v
    }()
    let greenView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("deinit", self)
    }
    
    // 커스텀뷰 자체에 touchesBegan과 touchesEnded를 설정해서 사용자가 누르고 있는 상호작용을 줄 수 있다. -> 현재는 뷰컨의 뷰에 적용되서 어디서 누르든 실행이 된다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 1
            }
        }
    }
    
    private func setAnimation() {
        // 시작
        sampleView.alpha = 0
        greenView.alpha = 0
        // 끝
        //        UIView.animate(withDuration: 3) {
        //            self.sampleView.alpha = 1
        //        }
        
        // 1초간, 2초 딜레이 후에 options이 실행, completion -> 끝난 다음엔 뭐할래?
        UIView.animate(withDuration: 1, delay: 2, options: [.curveLinear]) {
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .systemPink
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.greenView.alpha = 1
            }
        }
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
        view.addSubview(sampleView)
        view.addSubview(greenView)
        setAnimation()
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
        
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        greenView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view).offset(80)
        }
    }
    
}
