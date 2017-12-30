//
//  APIManager.swift
//  collectively
//
//  Created by Łukasz Bożek on 02/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import Alamofire

let API_KEY = "API_KEY"

func valueForAPIKey(keyname: String) -> String {
    // Get the file path for keys.plist
    let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist")
    
    // Put the keys in a dictionary
    let plist = NSDictionary(contentsOfFile: filePath!)
    
    // Pull the value for the key
    let value: String = plist?.object(forKey: keyname) as! String
    
    return value
}

class APIManager {
    let base = "https://api.becollective.ly/"
    
    var alamo : Alamofire.SessionManager!
    
    init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        self.alamo = Alamofire.SessionManager(configuration: configuration)
    }
    
    static let auth = Authentication()
    static let map = MapElements()
}
