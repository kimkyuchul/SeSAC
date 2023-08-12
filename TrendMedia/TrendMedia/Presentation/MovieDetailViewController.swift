//
//  MovieDetailViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit

final class MovieDetailViewController: BaseViewController {
    
    private lazy var detailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 65
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier, for: indexPath) as? MovieDetailTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieDetailHeaderView.identifier) as? MovieDetailHeaderView else {
            return UIView()
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.getDeviceHalfHeight()
    }
}
