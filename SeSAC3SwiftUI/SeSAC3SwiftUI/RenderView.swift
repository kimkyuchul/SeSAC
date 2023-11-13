//
//  RenderView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/13.
//

import SwiftUI

struct RenderView: View {
    
    @State var age = 10
    
    var body: some View {
        VStack {
            Text("Hue: \(age) \(Int.random(in: 1...100))")
            Text("Jack: \(Int.random(in: 1...100))")
            bran
            kokoView()
            Button("클릭") {
                age = Int.random(in: 1...100)
            }
        }
    }
    
    var bran: some View {
        Text("Bran: \(Int.random(in: 1...100))")
    }
}

struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        RenderView()
    }
}

struct kokoView: View {
    var body: some View {
        Text("koko: \(Int.random(in: 1...100))")
    }
}
