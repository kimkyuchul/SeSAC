//
//  OnboardingViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/26.
//

import UIKit

import SnapKit

enum PageViewType: CaseIterable {
    case first
    case second
    case third
    
    var viewController: UIViewController {
        switch self {
        case .first:
            return FirstViewController()
        case .second:
            return SecondViewController()
        case .third:
            return ThirdViewController()
        }
    }
    
    var image: UIImage {
        switch self {
        case .first:
            return UIImage(named: "Onboarding1")!
        case .second:
            return UIImage(named: "Onboarding2")!
        case .third:
            return UIImage(named: "Onboarding3")!
        }
    }
}

final class OnboardingViewController: BaseViewController {
    
    private let onbordingLabel: UILabel = {
        let label = UILabel()
        label.text = "TrendMedia로\n 영화 정보를 손쉽게 배껴가세요."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        pvc.delegate = self
        pvc.dataSource = self
        return pvc
    }()
    
    private let viewControllerList = PageViewType.allCases.map { $0.viewController }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        self.view.backgroundColor = .darkGray
    }
    
    private func configurePageViewController() {
        guard let first = viewControllerList.first else { return }
        pageViewController.setViewControllers([first], direction: .forward, animated: true)
    }
    
    override func setLayout() {
        super.setLayout()
    }
    
    override func setHierarchy() {
        // 자식 뷰 컨트롤러 추가
        addChild(pageViewController)
        view.addSubview(onbordingLabel)
        view.addSubview(pageViewController.view)
    }

    override func setConstraints() {
        
        onbordingLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(onbordingLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        return previousIndex < 0 ? nil : viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        return nextIndex >= viewControllerList.count ? nil : viewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = pageViewController.viewControllers?.first, let index = viewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
}
