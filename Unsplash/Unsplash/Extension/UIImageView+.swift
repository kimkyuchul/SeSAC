//
//  UIImageView+.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import UIKit

extension UIImageView {
    func setImageFromStringURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
            }

          guard let imageData = data else { return }

          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}
