//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 김규철 on 2023/08/16.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class PosterViewController: UIViewController {
    
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    private var list: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    private var secondList: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    private var thirdList: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    private var fourList: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionViewLayout()
        callAllRecommendation()
        
        let group = DispatchGroup()
        
        let id = [673, 674, 675, 675]
        
        for item in id {
            group.enter()
            callRecommendation(id: item) { data in
                if item == 673 {
                    self.list = data
                }
                group.leave()
            }
        }
    }
    
    
    @IBAction func sendNotification(_ sender: UIButton) {
        
        // 포그라운드에서 알림이 안뜨는게 디폴트
        // 알림이 백그라운드에서만 뜨게 하는게 애플의 정책이다.
        
        // 1. 컨텐츠 2. 언제 => 알림 보내!
        let content = UNMutableNotificationContent()
        content.title = "다마고치에게 물을 줘"
        content.body = "아직 레벨 3이에요. 물을 \(Int.random(in: 1...49)) 줘"
        content.badge = 100
        
        // timeInterval의 최솟값은 60이다.
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        // repeats(반복)을 false를 하면 timeInterval을 60 이하로 설정 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
    func callAllRecommendation() {
        let group = DispatchGroup() // DispatchGroup 생성
        
        // enter (Task + 1)
        group.enter()
        callRecommendation(id: 976573) { data in
            self.list = data
            group.leave() // levave (Task - 1)
        }
        
        // enter (Task + 1)
        group.enter()
        callRecommendation(id: 479718) { data in
            self.secondList = data
            group.leave() // levave (Task - 1)
        }
        
        // enter (Task + 1)
        group.enter()
        callRecommendation(id: 569094) { data in
            self.thirdList = data
            group.leave() // levave (Task - 1)
        }
        
        // enter (Task + 1)
        group.enter()
        callRecommendation(id: 565770) { data in
            self.fourList = data
            group.leave() // levave (Task - 1)
        }
        
        // Task == 0
        group.notify(queue: .main) {
            self.posterCollectionView.reloadData()
        }
    }
    
    func callRecommendation(id: Int, compleationHandler: @escaping (Recommendation) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(Key.tmdb)&language=ko-KR"
        AF.request(url, method: .get).validate().responseDecodable(of: Recommendation.self) { response in
            switch response.result {
            case .success(let value):
                compleationHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCollectionView() {
        // Protocol as Type
        // UICollectionViewDelegate은 프로토콜이다. => UICollectionViewDelegate을 채택하고 있는 어떠한 클래스도 들어올 수 있다.
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        posterCollectionView.register( UINib(nibName: HearderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HearderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout()  {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
    }
}

extension PosterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return list.results.count
        } else if section == 1 {
            return secondList.results.count
        } else if section == 2 {
            return thirdList.results.count
        } else {
            return fourList.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            let url = "https://www.themoviedb.org/t/p/w440_and_h660_face\(list.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if  indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w440_and_h660_face\(secondList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if  indexPath.section == 2 {
            let url = "https://www.themoviedb.org/t/p/w440_and_h660_face\(thirdList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if  indexPath.section == 3 {
            let url = "https://www.themoviedb.org/t/p/w440_and_h660_face\(fourList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HearderPosterCollectionReusableView", for: indexPath) as?  HearderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            header.titleLabel.text = "테스트 섹션@"
            header.titleLabel.font = UIFont(name: "GangwonStateot-SemiBold", size: 15)
            
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

//protocol Test: AnyObject {
//    func test()
//}
//
//class A: Test {
//    func test() {
//        <#code#>
//    }
//
//
//}
//
//class B: Test {
//    func test() {
//        <#code#>
//    }
//
//
//}
//
//class C: A {
//
//}
//
//// 프로토콜의 고급 특징 -> 타입으로써의 기능을 할 수 있다.
//// = B() 도 들어올 수 있다.
//// 프로토콜을 상속 받고 있는다면,
//let example: Test = A()
//
//// C는 A를 상속받고 있기 때문에 오류가 나지 않는다.
//// 만약 = B() <- 오류
//let value: A = C()



