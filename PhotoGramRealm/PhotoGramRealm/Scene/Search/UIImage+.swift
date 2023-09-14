//
//  UIImage+.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/14.
//

import UIKit

extension UIImage {
    static func fromURL(stringUrl: String, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: stringUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }

                guard let imageData = data, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }

                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        } else {
            completion(nil)
        }
    }
}
