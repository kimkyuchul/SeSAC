//
//  ListViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/21.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    @Published var market = [Market(market: "a", korean: "a", english: "a"),
                             Market(market: "a", korean: "a", english: "a"),
                             Market(market: "a", korean: "a", english: "a")] // Hashable하기 때문에 1개밖에 안나온다.
    
    func fetchAllMarket() {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Market].self, from: data)
                
                DispatchQueue.main.async {
                    self?.market = result
                }
                
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
