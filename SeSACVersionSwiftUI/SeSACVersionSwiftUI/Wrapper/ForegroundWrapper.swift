//
//  ForegroundWrapper.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

private struct ForegroundWrapper: ViewModifier {
    
    let color: Color
   
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .foregroundStyle(color)
        } else {
            content
                .foregroundColor(color)
        }
    }
}

extension View {
    func foreground(_ color: Color) -> some View {
        modifier( ForegroundWrapper(color: color) )
    }
}
