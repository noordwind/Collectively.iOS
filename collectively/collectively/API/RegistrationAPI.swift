//
//  RegistrationAPI.swift
//  collectively
//
//  Created by Łukasz Bożek on 19/06/2018.
//  Copyright © 2018 collectively. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RegistrationAPI {
    
    fileprivate func register(email: String, password: String) -> Single<Bool>  {
        let url = APIManager.shared.base + "sign-up"
        
        let param: [String: Any] = ["email": email,
                                    "name": "user1",
                                    "password": password,
                                    "provider": "collectively"]
  
        return Single<Bool>.create { emitter in
            APIManager.shared.alamo.request(url,
                                            method: .post,
                                            parameters: param,
                                            encoding: JSONEncoding.default)
                .responseJSON { response in
                    if let error = response.result.error {
                        print(error)
                        emitter(.error(error))
                    } else if let responseData = response.data {
//                        let decoder = JSONDecoder()
//                        do {
//                            let elements = try decoder.decode([MapModel].self, from: responseData)
                            emitter(.success(true))
//                        } catch {
//                            emitter(.error(error))
//                        }
                    } else {
                        emitter(.error(BackendError.objectSerialization(reason: "No data in response")))
                    }
            }
            
            return Disposables.create()
        }
    }
}
