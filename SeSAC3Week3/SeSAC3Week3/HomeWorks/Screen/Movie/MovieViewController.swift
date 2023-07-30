//
//  MovieViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit

final class MovieViewController: BaseViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    private var viewModel: MovieViewModel!
    
    private var movieList: [Movie] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = MovieViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "영화 Again"
        setTableView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func bind() {
        viewModel.setUpContents = { [weak self] in
            guard let self = self else { return }
            self.movieList = self.viewModel.movieData ?? self.movieList
        }
    }
    
     private func setTableView() {
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
