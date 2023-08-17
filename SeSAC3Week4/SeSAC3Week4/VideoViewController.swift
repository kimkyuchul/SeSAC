//
//  VideoViewController.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

struct Video {
    let author: String
    let datetime: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let link: String
    
    var contents: String {
            return "\(author) | \(playTime)회\n\(datetime)"
    }
}

final class VideoViewController: UIViewController {
    
    private var videoList: [Document] = [] {
        didSet {
            videoTableView.reloadData()
        }
    }
    // 페이지 수 관리
    var page = 1
    var isEnd = false // 현재 페이지가 마지막 페이지인지 점검하는 프로퍼티

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var videoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140
        
        searchBar.delegate = self
    }

}

extension VideoViewController {
    
    func callRequest(query: String, page: Int) {
        BaseService.shared.request(target: kakaoVideoAPI.getVideo(query: query, page: page), KaKaoVideo.self) { response in
            switch response {
            case .success(let value):
                print(value)
                self.videoList.append(contentsOf: value.documents)
                self.isEnd = value.meta.isEnd
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension VideoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 검색어가 바뀔 때 쌓인 페이지를 제거
        // 새로운 검색어이기 때문에 page를 1로 변경
        page = 1
        videoList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query, page: page)
    }
}
// UITableViewDataSourcePrefetching: iOS10이상 사용 가능한 프로토콜, cellForRowAt 메서드가 호출되기 전에 미리 호출됨
// videoList 갯수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    // prefetchRowsAt: 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            // videoList.count - 1 -> 최대 30개로 설정된 것 중 -1 즉, 29번째와 indexPath.row와 같으면
            // 카카오 api의 경우 최대 page가 15이기 때문에 page 카운트도 체크해준다.
            // isEnd가 false 일 때 page를 추가해줌
            if videoList.count - 1 == indexPath.row && page < 15 && !isEnd {
                // 페이지 수를 올려서 page + 1번째 페이지가 노출
                page += 1
                callRequest(query: searchBar.text!, page: page)
                
            }
        }
    }
    
    // cancelPrefetchingForRowsAt: 취소 기능: 직접 취소하는 기능을 구현해주어야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        // 빠르게 넘어갈 때, 해당 인덱스에 대한 정보를 준비안해도 될 거 같다고 할 때 (다운로드 취소) 쓴다.
        // 다운로드 취소 기능을 구현해야한다.
        print("=====취소: \(indexPaths)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as? VideoTableViewCell else { return UITableViewCell() }
        
        let row = videoList[indexPath.row]
        
        cell.titleLabel.text = videoList[indexPath.row].title
        
        var contents: String {
            return "\(row.author) | \(row.playTime)회\n\(row.datetime)"
        }
        
        cell.contentLabel.text = contents
        cell.thumbnailImageView.kf.setImage(with: URL(string: videoList[indexPath.row].thumbnail)) { image in
            switch image {
            case .success(_):
                print("성공")
                
            case .failure(_):
                print("실패")
            }
        }
        
        return cell
    }
    
    
}
