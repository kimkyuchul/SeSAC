//
//  MovieMapViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit

import SnapKit

enum TheaterType: String, CaseIterable {
    case all = "전체 보기"
    case cgv = "CGV"
    case lotte = "롯데시네마"
    case mega = "메가박스"
}

final class MovieMapViewController: BaseViewController {
    private lazy var mapView = MKMapView()
    let locationButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.image = UIImage(systemName: "target")
        config.baseForegroundColor = .black
        let button = UIButton(configuration: config)
        return button
    }()
    
    private let viewModel: MovieMapViewModel
    
    init(viewModel: MovieMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "영화관 보기"
        viewModel.checkDeviceLocationAuthorization()
        viewModel.setCoordinate()
        viewModel.checkDenied()
        bind()
        
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    @objc func filterButtonTapped() {
        let alert = UIAlertController(title: "영화관 선택해", message: nil, preferredStyle: .actionSheet)
        for theater in TheaterType.allCases {
            let alertAction = UIAlertAction(title: theater.rawValue, style: .default) { _ in
                self.filteredTheater(theater: theater)
            }
            alert.addAction(alertAction)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
        
    @objc func locationButtonTapped() {
        viewModel.checkDeviceLocationAuthorization()
        viewModel.checkDenied()
    }
    
    override func bind() {
        viewModel.locationCoordinate = { data in
            self.setRegionAndAnnotation(center: data)
        }
        
        viewModel.authorizationAlertShouldShow = { bool in
            if bool {
                self.showRequestLocationServiceAlert()
                self.setRegionAndAnnotation(center: CLLocationCoordinate2D(latitude: 37.5176577, longitude: 126.8864088))
            }
        }
        
        for i in viewModel.list.mapAnnotations {
            setAnnotation(by: i)
        }
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    private func setAnnotation(by theater: Theater) {
        let center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
        
        // 지도에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = theater.location
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    private func filteredTheater(theater: TheaterType) {
        if theater == .all {
            for i in viewModel.list.mapAnnotations {
                setAnnotation(by: i)
            }
            return
        }
        
        mapView.removeAnnotations(mapView.annotations)
        viewModel.list.mapAnnotations.filter { $0.type == theater.rawValue }.forEach { Theater in
            setAnnotation(by: Theater)
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    override func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func setHierarchy() {
        view.addSubview(mapView)
        view.addSubview(locationButton)
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        locationButton.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.top)
            make.leading.equalTo(mapView.snp.leading)
            make.height.width.equalTo(70)
        }
    }
}
