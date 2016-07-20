//
//  ServiceAnnotationMap.swift
//  iCanGo-iOS
//
//  Created by Alberto on 20/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation
import MapKit

class ServiceAnnotationMap : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title      = title
        self.subtitle   = subtitle
    }
}