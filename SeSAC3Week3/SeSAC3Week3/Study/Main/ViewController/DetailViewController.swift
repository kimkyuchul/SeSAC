//
//  DetailViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    
    //1.
    var data: ToDo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data else { return }
       print(data)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
