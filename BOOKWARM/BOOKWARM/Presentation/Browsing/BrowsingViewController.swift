//
//  BrowsingViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/02.
//

import UIKit


final class BrowsingViewController: UIViewController {
    
    @IBOutlet weak var PopulerTableView: UITableView!
        
    private let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4))
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 본 작품"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var recentlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size: CGFloat = view.getDeviceWidth() - (5 * 5)
        layout.itemSize = CGSize(width: size / 4, height: 150)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 5,
            bottom: 0,
            right: 5
        )
        layout.minimumLineSpacing =  Metric.inset
        layout.minimumInteritemSpacing = Metric.inset
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180), collectionViewLayout: layout)
        collectionView.backgroundColor = .darkGray
        collectionView.register(UINib(nibName: ResentlyCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ResentlyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var viewModel: BrowsingViewModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = BrowsingViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewLayout()
        setHierarchy()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func bind() {
           viewModel.binding = { [weak self] in
               guard let self = self else { return }
               DispatchQueue.main.async {
                   self.recentlyCollectionView.reloadData()
                   self.PopulerTableView.reloadData()
               }
           }
       }

    
    private func configureTableViewLayout() {
        let nib = UINib(nibName: BrowsingTableViewCell.identifier, bundle: nil)
        PopulerTableView.register(nib, forCellReuseIdentifier: BrowsingTableViewCell.identifier)
        PopulerTableView.rowHeight = 136
        PopulerTableView.tableHeaderView = headerView
        PopulerTableView.delegate = self
        PopulerTableView.dataSource = self
        PopulerTableView.backgroundColor = .darkGray
    }
    
    private func setHierarchy() {
        headerView.addSubview(titleLabel)
        headerView.addSubview(recentlyCollectionView)
    }
    
    private func setConstraints() {
        recentlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            recentlyCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            recentlyCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            recentlyCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            recentlyCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    private func prsentDetailView(index: Int, type: TransitionType) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let nav = UINavigationController(rootViewController: vc)
        vc.title = viewModel.movie[index].title
        vc.viewModel.movie = self.viewModel.movie[index]
        vc.viewModel.navigation = type
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
}

extension BrowsingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrowsingTableViewCell.identifier, for: indexPath) as? BrowsingTableViewCell else { return UITableViewCell() }
        
        let row = self.viewModel.movie[indexPath.row]
        
        cell.configureCell(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "인기있는 작품"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .boldSystemFont(ofSize: 17)
        header.textLabel?.textColor = .black
        header.textLabel?.sizeToFit()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prsentDetailView(index: indexPath.row, type: .edit)
    }
}

extension BrowsingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResentlyCollectionViewCell.identifier, for: indexPath) as? ResentlyCollectionViewCell else { return UICollectionViewCell() }
        
        let row = self.viewModel.movie[indexPath.row]
        
        cell.configureCell(row: row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        prsentDetailView(index: indexPath.item, type: .edit)
    }
}
