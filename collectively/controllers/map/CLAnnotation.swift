//
//  CLAnnotation.swift
//  collectively
//
//  Created by Łukasz Bożek on 03/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

public class CLAnnotation: NSObject {
    public var coordinate = CLLocationCoordinate2D(latitude: 39.208407, longitude: -76.799555)
    public var title: String? = " "
    public var subtitle: String?
    var problem: MapModel?
}

extension CLAnnotation: MKAnnotation {
    
}
