//
//  MovieViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit

final class MovieViewController: BaseViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "영화 Again"
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getList()
    }
    
     func setTableView() {
         movieTableView.backgroundColor = .tertiarySystemGroupedBackground
        movieTableView.rowHeight = 100
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.CellIdentifier)
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.CellIdentifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let row = self.movieList[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
}

extension MovieViewController {
    func getList() {
        URLSessionService.shard.getMovieList(page: 5) { result in
            self.movieList = result.Search
            print(self.movieList)
        }
    }
}
