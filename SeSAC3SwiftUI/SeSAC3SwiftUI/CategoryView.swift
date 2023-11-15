//
//  CategoryView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/15.
//

struct Category: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}

import SwiftUI

struct CategoryView: View {
    
    let category = [
        Category(name: "스릴러", count: 10),
        Category(name: "SF", count: 50),
        Category(name: "액션", count: 2),
        Category(name: "로맨스", count: 102),
        Category(name: "가족", count: 45),
        Category(name: "애니", count: 32),
        Category(name: "애니", count: 22)
    ]
    
    var body: some View {
        VStack {
            ForEach(category, id: \.id) { item in
                Text("\(item.name) \(item.count) 안녕")
                    .font(.largeTitle)
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
