//
//  UINavigationController+.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit


extension UINavigationController {
    
    func configureNavigationBarAppearance(bgColor: UIColor, shadowColor: UIColor? = nil, titleSize: CGFloat = 20, largeTitleSize: CGFloat = 40) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = bgColor
        appearance.shadowColor = shadowColor
        
        appearance.titleTextAttributes =
        [
            .foregroundColor : UIColor.black,
            .font : UIFont.boldSystemFont(ofSize: titleSize)
        ]
        
        appearance.largeTitleTextAttributes =
        [
            .foregroundColor : UIColor.black,
            .font : UIFont.boldSystemFont(ofSize: largeTitleSize)
        ]
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func configureLargeTitle(_ bool: Bool) {
        navigationBar.prefersLargeTitles = bool
    }
    
    
}
