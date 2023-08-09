//
//  UIImageView++.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/09.
//

import UIKit

import Kingfisher

extension UIImageView {
    func setImage(urlString: String) {
        ImageCache.default.retrieveImage(forKey: urlString, options: nil) { result in
            switch result {
            case .success(let value):
                if let image = value.image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    guard let url = URL(string: urlString) else { return }
                    // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정
                    let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
                    self.kf.setImage(with: resource) // 이미지를 셋
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
