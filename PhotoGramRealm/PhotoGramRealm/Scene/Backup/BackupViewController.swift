//
//  BackupViewController.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/07.
//

import UIKit

import Zip

final class BackupViewController: BaseViewController {
    
    private let backupButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        view.setTitle("backup", for: .normal)
        return view
    }()
    private let restoreButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("restore", for: .normal)
        return view
    }()
    private lazy var backupTableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .brown
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func backupButtonTapped() {
        
        //1. 백업하고자 하는 파일들의 경로 배열 생성
        // quickZipFiles할 때 [URL]
        var urlPaths = [URL]()
        
        //2. 도큐먼트 위치 (else 문으로 빠질 시 모달 등의 에러처리 필요)
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있다.")
            return
        }
        
        print(path)
        
        //3. 백업하고자 하는 파일 경로 ex ~~~/~~/~~/Document/default.realm
        let realmFile = path.appendingPathComponent("default.realm")
        
        print(realmFile)
        
        //4. 3번 경로가 유효한지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            print("백업할 파일이 없다.")
            return
        }
        
        //5. 압축하고자 하는 파일을 배열에 추가
        urlPaths.append(realmFile)
        
        //6. 압축
        do {
            // fileName -> ex) javierArchive\(random Int) -> 파일명이 계속 다르게 zip을 한다면 다수의 압축파일이 만들어 질 수 있다.
            // 하지만 지금 구현은 fileName: "javierArchive"로 설정되어 있어서 계속 덮어쓰기 중이다.
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "javierArchive")
            print(zipFilePath)
        } catch {
            print("압축에 실패했어요")
        }
        
        self.backupTableView.reloadData()
    }
    
    @objc func restoreButtonTapped() {
        
        // 파일 앱을 통한 복구 진행
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true)
    }
    
    override func configure() {
        super.configure()
        [backupTableView, backupButton, restoreButton].forEach { view in
            self.view.addSubview(view)
        }
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function, urls)
        
        // 파일앱에서 선택한 url
        guard let selectedFileURL = urls.first else {
            print("선택한 파일에 오류가 있다.")
            return
        }
        
        print("파일앱에서 선택한 url: \(selectedFileURL)")
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있어요.")
            return
        }
        
        // 도큐먼트 폴더 내 저장할 경로 설정
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        print("도큐먼트 폴더 내 저장할 경로 설정: \(sandboxFileURL)")
        
        // 경로에 복구한 파일(zip)이 이미 있는 지 확인
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            // 내 앱 내의 도큐먼트의 zip 이름이 javierArchive.zip 상수값으로 저장됨!
            let fileURL = path.appendingPathComponent("javierArchive.zip")
            
            do { // destination -> zip을 어디에 풀어줄건데?, overwrite -> 덮어쓰기
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("압축해제 완료: \(unzippedFile)")
                })

            } catch {
                print("압축 해제 실패")
            }
            
        } else {
        // 경로에 복구할 파일이 없을 때의 대응 -> 가지고 온 압축파일이 존재하지 않음
        // 파일앱에 있는 파일 복붙이 필요하다.
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("javierArchive.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("압축해제 완료: \(unzippedFile)")
                    
                    // 앱을 껏다켜야 복구한 데이터가 반영이 된다.
                    exit(0)
                })
                
            } catch {
                print("압축 해제 실패")
            }
        }
    }
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 도큐먼트 파일들이 있는 리스트
    func fetchZipList() -> [String] {
        var list: [String] = []
        
        do {
            guard let path = documentDirectoryPath() else { return list }
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            let zip = docs.filter { $0.pathExtension == "zip" }
            for i in zip {
                list.append(i.lastPathComponent)
            }
        } catch {
            print(error)
        }
        
        return list
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = fetchZipList()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 앱이 지워지면 해당 도큐먼트가 지워지기 때문에  저장되어있는 zip 파일도 삭제됨 -> zip을 앱 샌드박스로 옮겨둠
        showActivityViewController(fileName: fetchZipList()[indexPath.row])
    }
    
    func showActivityViewController(fileName: String) {
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있다.")
            return
        }
    
        
//        let backipFileURL = path.appendingPathComponent("javierArchive.zip")
        let backipFileURL = path.appendingPathComponent(fileName)
        
        let vc = UIActivityViewController(activityItems: [backipFileURL], applicationActivities: [])
        present(vc, animated: true)
    }
}
