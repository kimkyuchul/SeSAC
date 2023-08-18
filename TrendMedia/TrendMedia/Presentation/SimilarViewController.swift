//
//  SimilarViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/18.
//

import UIKit

import SnapKit

final class SimilarViewController: BaseViewController {
    
    enum SegmentSectionType: CaseIterable {
        case similar
        case recommendation
    }
    
    private var similarData: [SimilarData] = []
    
    private let segmentCotrol: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Similar", "Recommendation"])
//        segment.selectedSegmentIndex = 0
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Similar"
        self.view.backgroundColor = .systemRed
        self.segmentCotrol.selectedSegmentIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSimilarData(movieId: 402)
        self.similarCollectionView.reloadData()
    }
    
    @objc
    func segmentValueChanged(segment: UISegmentedControl) {
        switchSegment(index: self.segmentCotrol.selectedSegmentIndex)
    }
    
    private func switchSegment(index: Int) {
        let type = SegmentSectionType.allCases[index]
        
        switch type {
        case .similar:
            self.similarCollectionView.collectionViewLayout = configurationCollectionViewLayout(index: index)
            self.similarCollectionView.reloadData()
        case .recommendation:
            self.similarCollectionView.collectionViewLayout = configurationCollectionViewLayout(index: index)
            self.similarCollectionView.reloadData()
        }
    }
    
    private func configurationCollectionViewLayout(index: Int) -> UICollectionViewFlowLayout {
        let type = SegmentSectionType.allCases[index]
        switch type {
        case .similar:
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: view.getDeviceWidth(), height: view.getDeviceHeight() * 0.6)
            return flowLayout
        case .recommendation:
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: view.getDeviceWidth(), height: view.getDeviceHeight() * 0.3)
            return flowLayout
        }
    }
    override func setHierarchy() {
        view.addSubview(segmentCotrol)
        view.addSubview(similarCollectionView)
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
    }
}

extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = SegmentSectionType.allCases[self.segmentCotrol.selectedSegmentIndex]
        switch type {
        case .similar:
            print(self.similarData.count)
            return self.similarData.count
        case .recommendation:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let type = SegmentSectionType.allCases[self.segmentCotrol.selectedSegmentIndex]
        switch type {
        case .similar:
            let row = self.similarData[indexPath.item]
            cell.similarConfigureCell(row: row)
            return cell
        case .recommendation:
            return cell
        }
    }
}

extension SimilarViewController {
    func fetchSimilarData(movieId: Int) {
        BaseService.shared.request(target: MovieAPI.getSimilarAPI(movieId: movieId), Similar.self) { result in
            switch result {
            case .success(let data):
                self.similarData = data.results
                self.similarCollectionView.reloadData() 
            case .failure(let error):
                print(error)
            }
        }
    }
}
