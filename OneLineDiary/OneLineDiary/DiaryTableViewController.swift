//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    private var list = ["테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1", "테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2", "테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backColor(.brown)
        tableView.backgroundColor = .orange
        
        // 자동 height 설정
        // Dynamic height -> 1. automaticDimension 2. label numberOfLines 3. AutoLayout (여백)
        tableView.rowHeight = UITableView.automaticDimension
        
        // bundle: nil -> 프로젝트 내 기본적인 root 경로를 뜻함
        let nib = UINib(nibName: DiaryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DiaryTableViewCell.identifier)
    }

    @IBAction func pushCollectionViewButtonTapped(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let VC = sb.instantiateViewController(withIdentifier: "SearchCollectionViewController") as! SearchCollectionViewController
        
//        let nav = UINavigationController(rootViewController: VC)
        
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    @IBAction func addBarButtonItemTapped(_ sender: UIBarButtonItem) {
        
        //1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //2. 스토리보드 파일 내 뷰컨트롤러 찾기
        let VC = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        VC.title = "aaaas"
        //2-1 옵션 : 네비게이션 컨트롤러가 있는 형태로 present
        // nav를 사용한다먄, presnt와 모달 방식도 nav로 설정
        let nav = UINavigationController(rootViewController: VC)
        //3. 화면 전환 방식 설정
//        VC.modalTransitionStyle = .coverVertical // 모달 애니메이션
//        VC.modalPresentationStyle = .fullScreen // 모달 방식
        
        nav.modalTransitionStyle = .coverVertical // 모달 애니메이션
        nav.modalPresentationStyle = .fullScreen // 모달 방식
        
        //4. 화면 띄우기
        self.present(nav, animated: true)
    
//        self.navigationController?.pushViewController(VC, animated: true)
//        self.navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier, for: indexPath) as? DiaryTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.sizeToFit()
        cell.titleLabel.text = list[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //2. 스토리보드 파일 내 뷰컨트롤러 찾기
        let VC = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //3. 화면 전환 방식 설정
        VC.modalTransitionStyle = .crossDissolve // 모달 애니메이션
        VC.modalPresentationStyle = .fullScreen // 모달 방식
        
        VC.contents = list[indexPath.row]
        VC.title = list[indexPath.row]
        VC.backColor(.magenta)
        //4. 화면 띄우기
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    // 1. System Delegate
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 2. System Delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    //Custom Swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
////        UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
//
//    }
//
//    //Custom Swipe
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }

}
