//
//  PhotoViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import UIKit
import SnapKit

final class PhotoViewController: UIViewController {

    @IBOutlet weak var photoTableView: UITableView!
    
    private var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.delegate = self
        photoTableView.dataSource = self
        photoTableView.rowHeight = 100
        photoTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoTableViewCell")
        
        viewModel.fetchPhoto(query: "travis")
        
        viewModel.list.bind { [weak self] photo in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let data = viewModel.cellForRowAtPhoto(at: indexPath)
        cell.diaryImageView.setImageFromStringURL(stringUrl: data.urls.thumb)
        cell.titleLabel.text = data.user.username
        cell.dateLabel.text = data.created_at
        cell.contentLabel.text = data.description
        return cell
    }
}
