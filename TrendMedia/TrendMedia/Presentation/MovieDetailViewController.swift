//
//  MovieDetailViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit

final class MovieDetailViewController: BaseViewController {
    
    var detailData: TrandData?
    var creditList: [Cast] = [] {
        didSet {
            detailTableView.reloadData()
        }
    }
    
    private lazy var detailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
        tableView.register(MovieDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: MovieDetailHeaderView.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "출연/제작"
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    @objc
    func similarPageButtonTapped() {
        let VC = SimilarViewController()
        guard let castIndex = creditList.first else { return }
        VC.movieID = castIndex.id
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func setHierarchy() {
        view.addSubview(detailTableView)
    }
    
    override func setConstraints() {
        detailTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setNavigationBar() {
        if case TrandType.movie.rawValue = detailData?.mediaType {
            let rightBarButton = UIBarButtonItem(title: "추천 & 관련 영화", style: .plain, target: self, action: #selector(similarPageButtonTapped))
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
    }

    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier, for: indexPath) as? MovieDetailTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(row: creditList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieDetailHeaderView.identifier) as? MovieDetailHeaderView else {
            return UIView()
        }

        if let data = detailData {
            header.configureHeader(row: data)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.getDeviceHalfHeight()
    }
}

