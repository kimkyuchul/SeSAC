//
//  AsyncViewController.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

final class AsyncViewController: UIViewController {
    
    @IBOutlet weak var first: UIImageView!
    @IBOutlet weak var second: UIImageView!
    @IBOutlet weak var third: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        first.backgroundColor = .magenta
        print("1")
        
        DispatchQueue.main.async {
            // 스토리보드 혹은 코드에서 뷰가 그려지면서 cornerRadius를 그려서 여러 디바이스 마다 Radius값이 달라진다.
            self.first.layer.cornerRadius = self.first.frame.width / 2
            print("2")
        }
        
        print("3")
    }
    
    //sync async serial concurrent
    //UI Freezing
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.first.image = UIImage(data: data)
            }
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        first.layer.cornerRadius = first.frame.width / 2
//    }
}
