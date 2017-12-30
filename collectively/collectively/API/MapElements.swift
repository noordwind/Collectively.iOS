//
//  MapElements.swift
//  collectively
//
//  Created by Łukasz Bożek on 03/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class MapElements: APIManager {
    override init() { }
    
    func getElements() -> Single<[MapModel]> {
        return Single<[MapModel]>.create { emitter in
//        let key = "Bearer " + valueForAPIKey(keyname: API_KEY)
            let url = self.base + "remarks" + "?" + "&results=100"
            let headers: [String: String] = ["Content-Type": "application/json",
                                             "Accept": "application/json"]
            
            self.alamo.request(url,
                          headers: headers)
                .responseJSON { response in
                    if let error = response.result.error {
                        print(error)
                        emitter(.error(error))
                    } else if let responseData = response.data {
                        let decoder = JSONDecoder()
                        do {
                            let elements = try decoder.decode([MapModel].self, from: responseData)
                            emitter(.success(elements))
                        } catch {
                            emitter(.error(error))
                        }
                    } else {
                        emitter(.error(BackendError.objectSerialization(reason: "No data in response")))
                }
            }
            return Disposables.create()
        }
    }
}
