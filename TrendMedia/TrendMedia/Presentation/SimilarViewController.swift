//
//  SimilarViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/18.
//

import UIKit

import SnapKit

final class SimilarViewController: BaseViewController {
    
    enum SegmentControlSectionType: CaseIterable {
        case similar
        case recommendation
    }
    
    typealias SectionType = SegmentControlSectionType
    
    private var similarData: [SimilarData] = [] {
        didSet {
            setEmptyView(isEmptyData: similarData.isEmpty)
        }
    }
    
    private var recommendaionData: [RecommendaionData] = []
    
    var movieID = Int()
    
    private lazy var segmentCotrol: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Similar", "Recommendation"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segment
    }()
    private lazy var similarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.getDeviceWidth(), height: view.getDeviceHeight() * 0.6)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .tertiarySystemGroupedBackground
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        return collectionView
    }()
    private let emptyView = EmptyView(isHidden: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "관련 영화"
        self.view.backgroundColor = .tertiarySystemGroupedBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        featchAllData()
    }
    
    @objc
    func segmentValueChanged(segment: UISegmentedControl) {
        switchSegment(index: self.segmentCotrol.selectedSegmentIndex)
    }
    
    private func switchSegment(index: Int) {
        let type = SectionType.allCases[index]
        
        switch type {
        case .similar:
            if self.similarData.isEmpty {
                setEmptyView(isEmptyData: true)
            } else {
                setEmptyView(isEmptyData: false)
                self.similarCollectionView.collectionViewLayout = configurationCollectionViewLayout(index: index)
                self.similarCollectionView.reloadData()
            }
        case .recommendation:
            if self.recommendaionData.isEmpty {
                setEmptyView(isEmptyData: true)
            } else {
                setEmptyView(isEmptyData: false)
                self.similarCollectionView.collectionViewLayout = configurationCollectionViewLayout(index: index)
                self.similarCollectionView.reloadData()
            }
        }
    }
    
    private func configurationCollectionViewLayout(index: Int) -> UICollectionViewFlowLayout {
        let type = SectionType.allCases[index]
        let flowLayout = UICollectionViewFlowLayout()
        
        switch type {
        case .similar:
            flowLayout.itemSize = CGSize(width: view.getDeviceWidth(), height: view.getDeviceHeight() * 0.6)
            return flowLayout
        case .recommendation:
            flowLayout.itemSize = CGSize(width: view.getDeviceWidth(), height: view.getDeviceHeight() * 0.3)
            return flowLayout
        }
    }
    
    private func setEmptyView(isEmptyData: Bool) {
        if isEmptyData {
            self.emptyView.isHidden = false
            self.similarCollectionView.isHidden = true
        } else {
            self.emptyView.isHidden = true
            self.similarCollectionView.isHidden = false
        }
    }
    
    override func setHierarchy() {
        view.addSubview(segmentCotrol)
        view.addSubview(similarCollectionView)
        view.addSubview(emptyView)
    }
    
    override func setConstraints() {
        segmentCotrol.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentCotrol.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(similarCollectionView.snp.edges)
        }
    }
}

extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = SectionType.allCases[self.segmentCotrol.selectedSegmentIndex]
        switch type {
        case .similar:
            return self.similarData.count
        case .recommendation:
            return self.recommendaionData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        
        let type = SectionType.allCases[self.segmentCotrol.selectedSegmentIndex]
        switch type {
        case .similar:
            let row = self.similarData[indexPath.item]
            cell.similarConfigureCell(row: row)
            return cell
        case .recommendation:
            let row = self.recommendaionData[indexPath.item]
            cell.recommendationConfigureCell(row: row)
            return cell
        }
    }
}

extension SimilarViewController {
    func featchAllData() {
        let group = DispatchGroup()
        
        group.enter()
        fetchSimilarData(movieId: self.movieID) { [weak self] data in
            self?.similarData = data.results
            group.leave()
        }
        
        group.enter()
        fetchRecommendationData(movieId: self.movieID) { [weak self] data in
            self?.recommendaionData = data.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.similarCollectionView.reloadData()
        }
    }
    
    func fetchSimilarData(movieId: Int, completion: @escaping (Similar) -> Void) {
        BaseService.shared.request(target: MovieAPI.getSimilarAPI(movieId: movieId), Similar.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self.setEmptyView(isEmptyData: true)
                print(error.errorMessage)
            }
        }
    }
    
    func fetchRecommendationData(movieId: Int, completion: @escaping (Recommendaion) -> Void) {
        BaseService.shared.request(target: MovieAPI.getRecommendationsAPI(movieId: movieId), Recommendaion.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self.setEmptyView(isEmptyData: true)
                print(error.errorMessage)
            }
        }
    }
}
