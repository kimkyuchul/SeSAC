//
//  CustomAnnotation.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/23.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
