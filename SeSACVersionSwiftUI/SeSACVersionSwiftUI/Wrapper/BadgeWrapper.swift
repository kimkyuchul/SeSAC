//
//  BadgeWrapper.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

private struct BadgeWrapper: ViewModifier {
    
    let count: Int
       
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .badge(count)
        } else {
            content
        }
    }
}

extension View {
    func badges(_ count: Int) -> some View {
        modifier( BadgeWrapper(count: count) )
    }
}
