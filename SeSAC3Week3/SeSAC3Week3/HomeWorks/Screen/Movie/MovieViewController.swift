//
//  MovieViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit

final class MovieViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigator()
    }
    
    
    private func setNavigator() {
        self.title = "영화asdsadasdas"
        self.navigationController?.configureNavigationBarAppearance(bgColor: UIColor.tertiarySystemGroupedBackground)
        self.navigationController?.configureLargeTitle(true)
    }

}
