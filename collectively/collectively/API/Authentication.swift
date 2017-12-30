//
//  Authentication.swift
//  collectively
//
//  Created by Łukasz Bożek on 02/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import Alamofire

class Authentication: APIManager {
    override init() {
    }
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
    
    func authorization(email: String, password: String, completion: @escaping LoginResponse) {
        let url = base + "/sign-in"
        let param: [String: Any] = ["email": email,
                                    "password": password,
                                    "provider": "collectively"]
        
        
        alamo.request(url,
                      method: .post,
                      parameters: param,
                      encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                completion(true, response.error)
        }
    }
    
    func login(user: String, password: String, completion: @escaping LoginResponse) {
        oauth2.username = user
        oauth2.password = password
        
        //to exclude from doubleups
        self.oauth2.internalAfterAuthorizeOrFail = nil
        
        oauth2.authorize { authParameters, error in
            if let params = authParameters {
                print("Authorized! Access token is in `oauth2.accessToken`")
                print("Authorized! Additional parameters: \(params)")
                completion(true, nil)
            }
            else {
                print("Authorization was canceled or went wrong: \(String(describing: error))")   // error will not be nil
                completion(false, error)
            }
        }
    }
    
    func fb(token: String, completion: @escaping (Bool) -> Void) {
//        let key = "Bearer " + valueForAPIKey(keyname: API_KEY)
        let url = base + "/sign-in"
        let param: [String: Any] = ["accessToken": token,
                     "provider": "facebook"]

        
        alamo.request(url,
                      method: .post,
                      parameters: param,
                      encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                completion(true)
        }
    }
}
