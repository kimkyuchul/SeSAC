//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/22.
//

import UIKit
// 1. import CoreLocation
import CoreLocation
import MapKit

import SnapKit

class LocationViewController: UIViewController {
    
    // 2. 위치 매니저 생성: 윛에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    let kButton = UIButton()
    let sButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        setLayout()
        // 3. 델리게이트 연결
        locationManager.delegate = self
        mapView.delegate = self
        
//        // info.plist <<< 얼럿
//        locationManager.requestWhenInUseAuthorization()
    
        // locationManagerDidChangeAuthorization에서 체크해주기 때문에 viewDidLoad에서 또 호출되어 2번 호출이 된다.
        // 하지만 해당 뷰가 탭바에 연결되어있거나, 푸시되어서 올 경우 locationManagerDidChangeAuthorization가 실행되지 않기 때문에 두번 호출된다해도 그냥 호출해주는게 맞음
        checkDeviceLocationAuthorization()
        
        let center = CLLocationCoordinate2D(latitude: 37.58523, longitude: 127.05315)
        setRegionAndAnnotation(center: center)
        
        setAnnotation(type: 0)
    }
    
    private func setAnnotation(type: Int) {
//        37.592071, 127.055476 // 경희대
//        37.583628, 127.056504 // 시립대
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 37.592071, longitude: 127.055476)
        
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.583628, longitude: 127.056504)
        
        if type == 0 { //viewDidLoad
            mapView.addAnnotations([annotation1, annotation2])
        } else if type == 1 {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation2])
        }
    }
    
    // 맵에 위치와 핀을 설정
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        // 지도 중심 기반으로 보여질 범위 설정
//        let center = CLLocationCoordinate2D(latitude: 37.58523, longitude: 127.05315)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        // 지도에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = "집"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "오류", message: "위치 권한을 허용해줘. 기기의 '설정>개인정보 보호에서 위치 서비스를 좀 켜", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            
            // 설정에서 직접적으로 앱 설정 화면에 들어간적이 없다면
            // 한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이라서
            // 설정 페이지로 넘어갈지, 설정 상세 페이지 결정 X
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    // 디바이스 위치 서비스 체크
    func checkDeviceLocationAuthorization() {
        
        // This method can cause UI unresponsiveness if invoked on the main thread. Instead, consider waiting for the `-locationManagerDidChangeAuthorization:` callback and checking `authorizationStatus` first. <- iOS15부터 생긴 스레드 문제
        DispatchQueue.global().async {
            // Returns a Boolean value indicating whether location services are enabled on the device.
            // iOS 위치 서비스 활성화 체크
            if CLLocationManager.locationServicesEnabled() {
                // 현재 사용자의 위치 권한 상태를 가지고 온다.
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                print(authorization)
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                    
                }
    
            } else {
                print("위치 서비스가 꺼져 있어")
            }
            
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {

        switch status {
        // 최초로 사용자가 앱을 켰을 때
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 얼럿, infoplist
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            // didUpdateLocations 실행
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            print("default")
        }
    }
    
    
    private func setLayout() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        view.addSubview(kButton)
        kButton.addTarget(self, action: #selector(kButtonClicked), for: .touchUpInside)
        kButton.backgroundColor = .blue
        kButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.size.equalTo(50)
            make.leading.equalTo(view).offset(100)
        }
        
        view.addSubview(sButton)
        sButton.backgroundColor = .red
        sButton.addTarget(self, action: #selector(sButtonClicked), for: .touchUpInside)
        sButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.size.equalTo(50)
            make.trailing.equalTo(view).offset(-100)
        }
    }
    
    @objc func kButtonClicked() {
        setAnnotation(type: 1)
        print("==")
    }
    
    @objc func sButtonClicked() {
        print("aa")
    }
}

// 4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    // 한번만 실행되지 않는다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            print("======", coordinate)
            
            setRegionAndAnnotation(center: coordinate)
            
            // 날씨API 호출
            
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    // 권한이 없어서 못가져올 때 에러
    // 사용자의 위치를 가지고 오지 못한 경우 iOS 위치 업데이트가 필요한 시점에 알아서 여러번 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // 사용자의 권한 상태가 바뀔 때를 알려줌
    // 거부했다가 설정에서 변경을 했거나, 혹은 notDetermined 상태에서 허용을 했거나
    // 허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    // iOS14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        // 다시 iOS 권한을 체크
        checkDeviceLocationAuthorization()
    }
    
    // 사용자의 권한 상태가 바뀔 때를 알려줌
    // iOS14 이하
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension LocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
}
