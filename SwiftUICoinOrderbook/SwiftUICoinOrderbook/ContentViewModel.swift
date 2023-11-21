//
//  ContentViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/21.
//

import Foundation

final class ContentViewModel: ObservableObject {
    
    // view에서 사용 가능한 State를 덜어내고 Published로
    @Published var banner = Banner()
    @Published var market: [Market] = []
    
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
    
    func fetchBanner() {
        banner = Banner()
    }
}
