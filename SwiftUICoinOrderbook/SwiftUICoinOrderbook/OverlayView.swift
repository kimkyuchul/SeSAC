//
//  OverlayView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/21.
//

import SwiftUI

struct OverlayView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.yellow)
                    .frame(width: 150, height: 150)
                Text("하이하이하이하이하이하이하이하이하이하이하이")
            }
            
            Circle()
                .fill(.yellow)
                .frame(width: 150, height: 150)
                .overlay { //ex addSubView
                    Text("하이하이하이하이하이하이하이")
                }
        }
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView()
    }
}
