//
//  BeerViewController.swift
//  AlamofirePractice
//
//  Created by 김규철 on 2023/08/07.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

final class BeerViewController: UIViewController {
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTitleLabel: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    
    private var randomBeer: RandomBeer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRamdomBeer()
    }
    
    @IBAction func beerButtonTapped(_ sender: UIButton) {
        getRamdomBeer()
    }
}

extension BeerViewController {
    private func getRamdomBeer() {
        NetworkService.shared.getRamdomBeerData { [weak self] result in
            DispatchQueue.main.async {
                self?.beerTitleLabel.text = result.name
                self?.beerImageView.kf.setImage(with: URL(string: result.imageURL))
                self?.beerDescription.text = result.description
            }
        }
    }
}
