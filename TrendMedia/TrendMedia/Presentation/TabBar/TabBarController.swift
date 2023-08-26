//
//  TabBarController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    let movieListViewController = UINavigationController(rootViewController: MovieListViewController())
    let movieMapViewController = UINavigationController(rootViewController: MovieMapViewController(viewModel: MovieMapViewModel(locationService: DefaultLocationService())))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [movieMapViewController, movieListViewController]
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.backgroundColor = .white
        
        movieMapViewController.tabBarItem.title = "영화관 보기"
        movieListViewController.tabBarItem.title = "영화 리스트"
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
