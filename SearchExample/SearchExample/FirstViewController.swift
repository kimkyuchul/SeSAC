//
//  FirstViewController.swift
//  SearchExample
//
//  Created by 김규철 on 2023/08/04.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        print(#function)
    }
    

    @IBAction func startButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "isLaunched")
        
        print(UserDefaults.standard.set(true, forKey: "isLaunched"))
    }
    
    
    @IBAction func mainButtonClicked(_ sender: UIButton) {
        
        let widowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let scenDelegate = widowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LibraryCollectionViewController") as! LibraryCollectionViewController
        let nav = UINavigationController(rootViewController: vc)
        
        scenDelegate?.window?.rootViewController = nav
        scenDelegate?.window?.makeKeyAndVisible()
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
