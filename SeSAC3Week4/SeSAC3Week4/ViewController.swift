//
//  ViewController.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/07.
//

import UIKit

import Alamofire
import SwiftyJSON

struct Movie {
    var title: String
    var release: String
}



final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    private var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .green
        tableView.rowHeight = 61
        activityView.isHidden = true
        
    }

    func callRequest(date: String) {
        
        activityView.isHidden = false
        activityView.startAnimating()
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let name = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
                let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
                let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
                
                print(name, name1, name2)
                
//                self.movieList.append(contentsOf: [name, name1, name2])
                
                
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    
                    let movieNm = item["movieNm"].stringValue
                    let openDt = item["openDt"].stringValue

                    let data = Movie(title: movieNm, release: openDt)
                    self.movieList.append(data)
                }
                
                self.activityView.isHidden = true
                self.activityView.stopAnimating()
                self.tableView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        movieList.removeAll()
        
        //20220101 > 1. 8글자 2. 2023333 올바른 날짜 3. 날짜의 범위가 어제의 날짜까지
        callRequest(date: searchBar.text!)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.detailTextLabel?.text =  movieList[indexPath.row].release
        
        return cell
    }
    
    
}

