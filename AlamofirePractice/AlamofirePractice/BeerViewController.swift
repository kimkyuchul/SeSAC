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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBeerInfo()
    }


}


extension BeerViewController {
    func getBeerInfo() {
        AF.request(APIConstant.baseURL, method: .get).validate(statusCode: 200...399).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                guard let name = json[0]["name"].string else { return }
                guard let imageURL = json[0]["image_url"].string else { return }
                guard let description = json[0]["description"].string else { return }
                
                DispatchQueue.main.async {
                    self.beerTitleLabel.text = name
                    self.beerImageView.kf.setImage(with: URL(string: imageURL))
                    self.beerDescription.text = description
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
