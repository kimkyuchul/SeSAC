//
//  AsyncImageView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/15.
//

import SwiftUI

struct AsyncImageView: View {
    
    let url = URL(string: "https://picsum.photos/100")!
    
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            else if phase.error != nil {
//                ProgressView() // Indicates an error.
                Image(systemName: "star")
            }
            else {
                Image(systemName: "star")
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
