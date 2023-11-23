//
//  NavigationBarWrapper.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

private struct NavigationBarWrapper<Leading: View, Trailing: View>: ViewModifier {
    
    let leading: Leading
    let trailing: Trailing
    
    init(@ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: { leading })
                    // content의 타입이 () -> Content 이기 때문에 대괄호 안에 넣어준다.
                    ToolbarItem(placement: .navigationBarTrailing, content: { trailing })
                }
        } else {
            content // (leading: L, trailing: T) -> some View where L : View, T : View
                .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
}

extension View {
    func navigationBar(
        @ViewBuilder leading: () -> some View,
        @ViewBuilder trailing: () -> some View
    ) -> some View {
        modifier( NavigationBarWrapper(leading: leading, trailing: trailing) )
    }
}
