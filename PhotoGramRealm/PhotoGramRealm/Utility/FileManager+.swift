//
//  FFileManager+.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    // 도큐먼트 폴더에서 이미지를 가져오는 메서드
    func loadImageFromDocument(fileName: String) -> UIImage {
        // 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")! }
        // 경로 설정(세부 경로, 이미지가 저장되어 있는 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
    }
    
    // 도큐먼트 폴더에 이미지를 저장하는 메서드
    func saveImageToDocument(fileName: String, image: UIImage) {
        // 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        
        // file:///Users/kimkyuchul/Library/Developer/CoreSimulator/Devices/75617C30-8F6A-4942-9965-2D98CE21EA9C/data/Containers/Data/Application/F77E9BC2-C87B-4899-9247-194566AC0B2B/Documents/123.jpg
        // 123.jpg를 추가 하는 것
        // 저장할 위치 경로 설정(세부 경로, 이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // 이미지 변환
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 이미지 저장
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        // 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 경로 설정(세부 경로, 이미지가 저장되어 있는 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
}
