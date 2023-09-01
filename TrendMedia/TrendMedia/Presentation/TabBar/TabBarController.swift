//
//  TabBarController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let movieListViewController = UINavigationController(rootViewController: MovieListViewController())
    private let movieMapViewController = UINavigationController(rootViewController: MovieMapViewController(viewModel: MovieMapViewModel(locationService: DefaultLocationService())))
    private let profileViewController = UINavigationController(rootViewController: ProfileViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [movieListViewController, movieMapViewController, profileViewController]
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.backgroundColor = .white
        
        movieMapViewController.tabBarItem.title = "영화관 보기"
        movieListViewController.tabBarItem.title = "영화 리스트"
        profileViewController.tabBarItem.title = "프로필"
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
