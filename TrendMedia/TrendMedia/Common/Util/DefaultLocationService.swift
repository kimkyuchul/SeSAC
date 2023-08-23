//
//  DefaultLocationService.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/23.
//

import Foundation
import CoreLocation

class DefaultLocationService: NSObject {
    var locationManager: CLLocationManager?
    var coordinate: ((CLLocationCoordinate2D) -> Void)?
    var authorizationStatus: ((CLAuthorizationStatus) -> Void)?
    
    var authorizationStatusHandler: CLAuthorizationStatus = .notDetermined {
        didSet {
            authorizationStatus?(authorizationStatusHandler)
        }
    }
    var locationUpdateHandler = CLLocationCoordinate2D() {
        didSet {
            coordinate?(locationUpdateHandler)
        }
    }
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func requestAuthorization() {
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func setAuthorizationStatusHandler(handler: @escaping (CLAuthorizationStatus) -> Void) {
        handler(authorizationStatusHandler)
    }
        
    func setLocationUpdateHandler(handler: @escaping (CLLocationCoordinate2D?) -> Void) {
        handler(locationUpdateHandler)
        print(locationUpdateHandler)
    }
    
    func checkLocationAuthorization() {
        switch self.authorizationStatusHandler {
        case .notDetermined:
            self.authorizationStatusHandler = .notDetermined
            self.requestAuthorization() 
        case .restricted, .denied:
            self.authorizationStatusHandler = .denied
        case .authorizedWhenInUse, .authorizedAlways:
            self.authorizationStatusHandler = .authorizedWhenInUse
            self.startLocation()
        @unknown default:
            break
        }
    }
}

extension DefaultLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            locationUpdateHandler = coordinate
            print("===\(#function)", locationUpdateHandler)
            
        }
        
        stopLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("========\(#function)", manager.authorizationStatus.rawValue)
        authorizationStatusHandler = manager.authorizationStatus
        checkLocationAuthorization()
    }
}
