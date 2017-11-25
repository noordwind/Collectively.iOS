//
//  LocationModel.swift
//  collectively
//
//  Created by Łukasz Bożek on 03/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationModel: Mappable {
//    ▿ 0 : 2 elements
//    - key : coordinates
//    ▿ value : 2 elements
//    - 0 : 20.05823493003845
//    - 1 : 50.07254512287458
//    ▿ 1 : 2 elements
//    - key : latitude
//    - value : 50.07254512287458
//    ▿ 2 : 2 elements
//    - key : longitude
//    - value : 20.05823493003845
//    ▿ 3 : 2 elements
//    - key : type
//    - value : Point
//    ▿ 4 : 2 elements
//    - key : address
//    - value : Melchiora Wańkowicza 8, Kraków, Poland
    var longitude: Double!
    var latitude: Double!
    var address: String!
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        address <- map["address"]
    }
}
