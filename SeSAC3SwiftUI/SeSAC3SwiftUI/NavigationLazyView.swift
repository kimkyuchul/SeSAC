//
//  NavigationLazyView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/16.
//

import SwiftUI

struct NavigationLazyView<T: View>: View {
    let build: () -> T
    
    init(_ build: @autoclosure @escaping () -> T) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}

