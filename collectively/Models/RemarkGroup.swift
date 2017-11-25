//
//  RemarkGroup.swift
//  collectively
//
//  Created by Łukasz Bożek on 03/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import ObjectMapper

class RemarkGroup: Mappable {
//    - key : "group"
//    ▿ value : 6 elements
//    ▿ 0 : 2 elements
//    - key : criteria
//    - value : <null>
//    ▿ 1 : 2 elements
//    - key : id
//    - value : 46eb46df-329a-46e3-bdf3-4b433ec8e3af
//    ▿ 2 : 2 elements
//    - key : memberRole
//    - value : <null>
//    ▿ 3 : 2 elements
//    - key : name
//    - value : ZZM Kraków
//    ▿ 4 : 2 elements
//    - key : memberCriteria
//    - value : <null>
//    ▿ 5 : 2 elements
//    - key : members
//    - value : <null>
    var name: String!
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        name <- map["name"]
    }
}
