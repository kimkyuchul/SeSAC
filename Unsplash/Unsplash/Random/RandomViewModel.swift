//
//  RandomViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/18.
//

import Foundation


class RandomViewModel {
    
    var randomPhotoList: Observable<[ImageInfo]> = Observable([])
    
    func viewDidLoadEvent() {
        fetchRandom()
    }
}


extension RandomViewModel {
    func fetchRandom() {
        RandomService.shared.searchPhoto() { [weak self] result in
            self?.randomPhotoList.value = result
            print(self?.randomPhotoList.value)
        }
    }
}
