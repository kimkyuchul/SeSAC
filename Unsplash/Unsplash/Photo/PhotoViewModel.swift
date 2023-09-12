//
//  PhotoViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import Foundation

class PhotoViewModel {
    
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    var numberOfRowsInSection: Int {
        list.value.results?.count ?? 0
    }
    
    func cellForRowAtPhoto(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results![indexPath.row]
    }
}

extension PhotoViewModel {
    func fetchPhoto(query: String) {
        APIService.shared.searchPhoto(query: query) { [weak self] photo in
            guard let photo = photo else {
                return
            }
            self?.list.value = photo
        }
    }
}
