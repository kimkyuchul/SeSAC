//
//  UIViewContoller+.swift
//  seSACFramework
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

extension UIViewController {
    
    public func sesacShowAlert(title: String, message: String, buttonTitle: String, buttinAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttonTitle, style: .default, handler: buttinAction)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    public func sesacShowActivityViewController(image: UIImage, url: String, text: String) {
        let vc = UIActivityViewController(activityItems: [image, url, text], applicationActivities: nil)
        vc.excludedActivityTypes = [.mail] // 안보이게 설정할 항목
        present(vc, animated: true)
    }
}
