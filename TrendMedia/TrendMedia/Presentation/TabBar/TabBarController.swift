//
//  TabBarController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    let movieListViewController = UINavigationController(rootViewController: MovieListViewController())
    let movieMapViewController = UINavigationController(rootViewController: MovieMapViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [movieListViewController, movieMapViewController]
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.backgroundColor = .white
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
