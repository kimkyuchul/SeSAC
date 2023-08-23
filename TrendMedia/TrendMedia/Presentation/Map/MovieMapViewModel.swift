//
//  MovieMapViewModel.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/23.
//

import Foundation
import CoreLocation

class MovieMapViewModel {

    var locationCoordinate: ((CLLocationCoordinate2D) -> Void)?
    var authorizationAlertShouldShow: ((Bool) -> Void)?

    var list = TheaterList()
    
    private let locationService: DefaultLocationService
    
    init(locationService: DefaultLocationService) {
        self.locationService = locationService
    }
        
    func setRegionAndAnnotation() {
        locationService.coordinate = { coordinate in
            self.locationCoordinate?(coordinate)
        }
    }
    
    func checkDenied() {
        locationService.authorizationStatus = { authorization in
            if authorization == .denied {
                self.authorizationAlertShouldShow?(true)
            } else {
                self.authorizationAlertShouldShow?(false)
            }
        }
    }
        
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                self.authorizationAlertShouldShow?(true)
                return
            }
            
            DispatchQueue.main.async {
                self.locationService.checkLocationAuthorization()
            }
        }
    }
}
