//
//  UIView+.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//


import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func getDeviceHalfHeight() -> CGFloat {
        return UIScreen.main.bounds.height * 0.5
    }
}

