//
//  APIManager.swift
//  collectively
//
//  Created by Łukasz Bożek on 02/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    let base = "https://api-dev.becollective.ly/"
    
    var alamo : Alamofire.SessionManager!
    
    init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        self.alamo = Alamofire.SessionManager(configuration: configuration)
    }
    
    static let auth = Authentication()
}
