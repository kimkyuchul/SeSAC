//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        serialSync()
        //        serialAsync()
        //        globalSync()
        //        globalAsync()
//        globalAsyncTwo()
        dispatchGroup()
    }
    
    func globalAsyncTwo() {
        print("Start")
        
        
        for i in 1...100 {
            
            // 알바생이 100만큼 생기는거다.
            // 알바생들이 각각 일도 진행
            DispatchQueue.global().async {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func globalAsync() {
        print("Start")
        DispatchQueue.global().async {
            for i in 1...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func globalSync() {
        print("Start")
        // DispatchQueue.global().sync
        // global().sync는 메인스레드에서 수행하는거랑 동일하다.
        // 그냥 작업만 다른 스레드에 맡기는거뿐 작업은 동기적으로 진행되기 때문이다.
        DispatchQueue.global().sync {
            for i in 1...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    func serialAsync() {
        print("Start")
        
        // 메인 스레드의 일이 끝나고 main.async의 일이 실행된다.
        // 왜냐하면 하나의 스레드에서 진행되고 있기 때문이다.
        DispatchQueue.main.async {
            for i in 1...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func serialSync() {
        print("Start")
        
        for i in 1...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        // 데드락
        DispatchQueue.main.sync {
            for i in 101...200 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        print("End")
    }
    
    
    func dispatchGroup() {
        
        let group = DispatchGroup()
        
        // 백그라운드 우선순위 qos
        DispatchQueue.global(qos: .background).async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            for i in 301...400 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("notify")
        }
    }
}
