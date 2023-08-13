//
//  MovieDetailViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit

final class MovieDetailViewController: BaseViewController {
    
    var detailData: MovieDetail?
    private var creditList: [Cast] = [] {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCredit(movieId: detailData?.id ?? 0)
    }
    
    override func setHierarchy() {
        view.addSubview(detailTableView)
    }
    
    override func setConstraints() {
        detailTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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

extension MovieDetailViewController {
    func fetchCredit(movieId: Int) {
        BaseService.shared.request(target: MovieListAPI.getCreditsAPI(movieId: movieId), Credit.self) { result in
            switch result {
            case .success(let data):
                self.creditList = data.cast
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
