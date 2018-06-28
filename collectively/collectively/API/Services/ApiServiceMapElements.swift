//
//  ApiServiceMapElements.swift
//  collectively
//
//  Created by Łukasz Bożek on 28/06/2018.
//  Copyright © 2018 collectively. All rights reserved.
//

import Foundation

class ApiServiceMapElements: BaseApiService {
    override var requestUrl: String? {
        return "remarks?&results=" + "\(self.batch)"
    }
    
    private let batch: Int
    
    init(batch: Int) {
        self.batch = batch
        super.init()
        decoder = ApiResponseJSONDecoder<[MapModel]>()
    }
}
