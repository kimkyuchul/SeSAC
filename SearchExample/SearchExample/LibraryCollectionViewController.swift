//
//  ViewController.swift
//  SearchExample
//
//  Created by jack on 2023/08/04.
//
 
import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    var list = MovieInfo()
    
    // 1. 검색어 배열로 변경
    var searchList: [Movie] = []
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 처음 앱 실행 시 전체 데이터 보여주기
        searchList = list.movie

        configureSearchBar()
        collectionViewLayout()
 
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        
        let title = searchList[sender.tag].title
        
        //2. 원본 배열에서 영화 정보 조회
        //3. 해당 영화가 원본 배열에서 몇번째 인덱스에 있는 지 확인
        for (index, item) in list.movie.enumerated() {
            if item.title == title {
                list.movie[index].like.toggle()
            }
        }
        
        searchList[sender.tag].like.toggle()
        collectionView.reloadData()
        
        // 원본 list에서 제목을 통해 영화를 찾고,
        // 그 영화의 인덱스를 통해 searchList[sender.tag].like.toggle()을 해줘야 함
    }
     
    func searchQuery(text: String) {
        
        searchList.removeAll()
        
        for item in list.movie {
            
            if item.title.contains(text) { // movie의 Title에 서치바 텍스트 포함되어 있다면
                searchList.append(item) // movie 구조체를 searchlist에 담기
            }
        }
        
        collectionView.reloadData()
    }

}

extension LibraryCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchQuery(text: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        searchQuery(text: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchList = list.movie // 취소 버튼 클릭 시 전체 데이터 보여주기
        searchBar.text = ""
        collectionView.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
}

extension LibraryCollectionViewController {
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as! LibraryCollectionViewCell
        
        let data = searchList[indexPath.row]
        cell.configureCell(data: data)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    
}

extension LibraryCollectionViewController {
    
    static let identifier = "LibraryCollectionViewController"
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
    }
 
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        navigationItem.titleView = searchBar
    }
    
}
