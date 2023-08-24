//
//  SeSACButton.swift
//  SeSAC3Week5
//
//  Created by 김규철 on 2023/08/21.
//

import UIKit

class seSACButton: UIButton {
    
    @IBInspectable
    var corner: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
}
