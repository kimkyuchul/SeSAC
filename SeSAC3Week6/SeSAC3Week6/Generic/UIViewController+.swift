//
//  UIViewController+.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 present
        case presentNavigation //네비게이션 임베드 된 present
        case presentFullNavigation //네비게이션 임베드 된 fullscreen present
        case push
    }
    /*
     "고래밥" > String
     String.self > String.Type
     */
    // T.Type 메타타입 -> 타입 그 자체를 다운 캐스팅 시 사용
    func transition<T: UIViewController>(viewController: T.Type, stroyBoard: String, style: TransitionStyle) {
        let sb = UIStoryboard(name: stroyBoard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else { return }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func sumInt(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func sumDouble(a: Double, b: Double) -> Double {
        return a + b
    }
    
    func sumFloat(a: Float, b: Float) -> Float {
        return a + b
    }
    
    
    // Generic: 타입에 유연하게 대응하기 위한 요소
    // 코드 중복과 재사용 대응에 좋아 추상적인 표현 가능
    func sum<Kyuchul: AdditiveArithmetic>(a: Kyuchul, b: Kyuchul) -> Kyuchul {
        // Binary operator '+' cannot be applied to two 'Kyuchul' operands
        // +가 동작하기 위해선 숫자만 들어와야 한다.
        return a + b
    }
    
    func sum<Kyuchul: AdditiveArithmetic, A>(a: Kyuchul, b: Kyuchul) -> A {
        return a + b as! A
    }
            
    func configureBorder(view: UIButton) {
        
    }
    
    func configureBorder(view: UIImageView) {
        
    }
    
    func configureBorder(view: UITextField) {
        
    }
    
    // Type Parameter: 타입의 종류는 알려주지 않지만, 모두 같은 타입이 들어갈 것을 암시, 플레이스 홀더와 같은 역할
    // Type Constraints: (ex -> : UIView) 클래스 제약, 프로토콜 제약
    // UpperCased
    func configureBorder<T: UIView>(view: T) {
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.magenta.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
    }
}
