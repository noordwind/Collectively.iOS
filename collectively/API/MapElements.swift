//
//  MapElements.swift
//  collectively
//
//  Created by Łukasz Bożek on 03/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import Alamofire

class MapElements: APIManager {
//    https://api.becollective.ly/
//?page=1&results=10&latitude=%60%60&longitude=%60%60&description=%60%60&radius=1000&authorId=%60%60&groupId=%60%60&resolverId=%60%60&userFavorites=%60%60&latest=false&disliked=false&onlyLiked=false&onlyDisliked=false&states=active&categories=%60%60&tags=%60%60"
    
    func getElements(completion: @escaping ([MapModel]) -> Void) {
//        let key = "Bearer " + valueForAPIKey(keyname: API_KEY)
        let url = base + "remarks" + "?" + "&results=100"
        let headers: [String: String] = ["Content-Type": "application/json",
                                         "Accept": "application/json"]
//                                         "Authorization": key]
//        url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.URLQueryParameterAllowedCharacterSet())!
        
        alamo.request(url,
                      headers: headers)
            .responseJSON { response in
                guard let json = response.result.value as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                completion(self.mapToMapElements(json: json))
            }
    }
    
    func mapToMapElements(json: [[String: Any]]) -> [MapModel] {
        var mapElements = [MapModel]()
        for elem in json {
            mapElements.append(MapModel(JSON: elem)!)
        }
        return mapElements
    }
}
