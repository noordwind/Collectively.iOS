//
//  Authentication.swift
//  collectively
//
//  Created by Łukasz Bożek on 02/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation

let API_KEY = "API_KEY"

func valueForAPIKey(keyname: String) -> String {
    // Get the file path for keys.plist
    let filePath = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")
    
    // Put the keys in a dictionary
    let plist = NSDictionary(contentsOfFile: filePath!)
    
    // Pull the value for the key
    let value:String = plist?.objectForKey(keyname) as! String
    
    return value
}

class Authentication: APIManager {
    let shared = Authentication()

    //    register
    //    Content-Type:application/json
    //    Accept:application/json
    //    Authorization:Bearer API_KEY
    //
    //    {
    //    "email": "user1@email.com",
    //    "name": "user1",
    //    "password": "secret",
    //    "provider": "collectively"
    //    }
    
    //    facebook auth
    //    HEADERS
    //    Content-Type:application/json
    //    Accept:application/json
    //    Authorization:Bearer API_KEY
    //    BODY
    //    {
    //    "accessToken": "FACEBOOK_ACCESS_TOKEN",
    //    "provider": "facebook"
    //    }
    
    func fb() {
        let key = "Bearer " + valueForAPIKey(keyname: API_KEY)
        let url = base + "/sign-in"
        let headers = ["Content-Type": "application/json",
                        "Accept": "application/json",
                        "Authorization": key]
        alamo.request(url, headers: headers)
            .responseJSON { (response) in
                
        }
    }
}
