//
//  MapViewModel.swift
//  collectively
//
//  Created by Łukasz Bożek on 30/12/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import Alamofire
import MapKit


class MapViewModel: NSObject {
    // MARK: - Properties
    var models = [MapModel]()
    var service: ApiService?
    
    lazy var serviceBuilder: (Int) -> ApiService = { batch in
        return ApiServiceMapElements(batch: batch)
    }
    var batch = 100
    
    // MARK: - Instance methods
    func getMapModels(completion: @escaping (Result<[MapModel]>) -> Void) {
        service = serviceBuilder(batch)
        service?.success = { [weak self] data in
            if let mapElements = data as? [MapModel] {
                self?.models = (self?.models ?? []) + mapElements
                completion(.success(mapElements))
            } else {
                let error = ApiErrorsFactory.makeError(for: .invalidDecodedData)
                completion(.failure(error))
            }
        }
        
        service?.failure = { error in
            completion(.failure(error))
        }
        
        service?.start()
//        APIManager.map.getElements()
//            .debug()
//            .retry(5)
//            .subscribe { (event) in
//                switch event {
//                case .success(let results):
//                    weakSelf.models.value = results
//                    emitter(.completed)
//                case .error(let error):
//                    emitter(.error(error))
//                }
//            }
//        }
    }
    
    func makeAnnotations() -> [CLAnnotation] {
        var anns = [CLAnnotation]()
        
        for el in self.models {
            let ann = CLAnnotation()
            ann.coordinate = CLLocationCoordinate2D(latitude: el.location.latitude, longitude: el.location.longitude)
            
            ann.title = el.group?.name ?? "Brak grupy!"
            ann.subtitle = el.description
            ann.problem = el
            anns.append(ann)
        }
        
        return anns
    }
}
