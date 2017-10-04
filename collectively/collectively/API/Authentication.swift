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
    
    func fb(token: String, completion: @escaping (Bool) -> Void) {
        let key = "Bearer " + valueForAPIKey(keyname: API_KEY)
        let url = base + "/sign-in"
        let headers: [String: String] = ["Content-Type": "application/json",
                        "Accept": "application/json",
                        "Authorization": key]
        let param: [String: Any] = ["accessToken": token,
                     "provider": "facebook"]
//        request(
//            _ url: URLConvertible,
//            method: HTTPMethod = .get,
//            parameters: Parameters? = nil,
//            encoding: ParameterEncoding = URLEncoding.default,
//            headers: HTTPHeaders? = nil)
        alamo.request(url,
                      method: .post,
                      parameters: param,
                      encoding: JSONEncoding.default,
                      headers: headers)
            .responseJSON { response in
                print(response)
                completion(true)
        }
    }
}
