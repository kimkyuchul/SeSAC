//
//  PhotoViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import UIKit

final class PhotoViewController: UIViewController {

    @IBOutlet weak var photoTableView: UITableView!
    
    private var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.delegate = self
        photoTableView.dataSource = self
        
        viewModel.fetchPhoto(query: "travis")
        
        viewModel.list.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.photoTableView.reloadData()
            }
        }
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell")!
        let data = viewModel.cellForRowAtPhoto(at: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
}
