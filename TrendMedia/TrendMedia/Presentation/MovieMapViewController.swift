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

class MovieMapViewController: BaseViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "영화관 보기"
        
    }
    
    @objc func filterButtonTapped() {
        
    }
    
    override func setDelegate() {
        locationManager.delegate = self
    }
    
    override func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func setHierarchy() {
        view.addSubview(mapView)
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}
