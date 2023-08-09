//
//  VideoViewController.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON

struct Video {
    let author: String
    let datetime: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let url: String
    
    var contents: String {
            return "\(author) | \(playTime)회\n\(datetime)"
    }
}

final class VideoViewController: UIViewController {
    
    private var videoList: [Video] = []

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var videoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.rowHeight = 140
        
        searchBar.delegate = self
    }

}

extension VideoViewController {
    
    func callRequest(query: String) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text!)&size=30"
        let header: HTTPHeaders = ["Authorization":"KakaoAK \(APIKey.kakaoKey)"]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                // response가 옵셔널 체이닝이기 때문에 옵셔널이 올 시 처리가 필요
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    for item in json["documents"].arrayValue {
                        let author = item["author"].stringValue
                        let date = item["datetime"].stringValue
                        let time = item["play_time"].intValue
                        let thumbnail = item["thumbnail"].stringValue
                        let title = item["title"].stringValue
                        let link = item["url"].stringValue
                        
                        let data = Video(author: author, datetime: date, playTime: time, thumbnail: thumbnail, title: title, url: link)
                        
                        self.videoList.append(data)
                    }
                    
                    self.videoTableView.reloadData()
                    
                } else {
                    print("문제가 발생.")
                }
                
                
                print(self.videoList)
            
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension VideoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        videoList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query)
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifi, for: indexPath) as? VideoTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = videoList[indexPath.row].title
        cell.contentLabel.text = videoList[indexPath.row].contents
        
        return cell
    }
    
    
}
