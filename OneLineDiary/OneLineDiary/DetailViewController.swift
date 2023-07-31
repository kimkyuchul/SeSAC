//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contents = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = contents
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        //root뷰로 바로 팝
//        navigationController?.popToRootViewController(animated: <#T##Bool#>)
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
