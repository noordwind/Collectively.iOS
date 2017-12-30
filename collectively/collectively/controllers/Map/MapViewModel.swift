//
//  MapViewModel.swift
//  collectively
//
//  Created by Łukasz Bożek on 30/12/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import MapKit
import RxSwift


class MapViewModel: NSObject {
    // MARK: - Properties
    var models: Variable<[MapModel]> = Variable([])
    var disposeBag = DisposeBag()
    
    // MARK: - Instance methods
    func getMapModels() -> Completable {
        return Completable.create { [weak self] emitter in
            guard let weakSelf = self else { return Disposables.create() }
            APIManager.map.getElements()
                .debug()
                .retry(5)
                .subscribe { (event) in
                    switch event {
                    case .success(let results):
                        weakSelf.models.value = results
                        emitter(.completed)
                    case .error(let error):
                        emitter(.error(error))
                    }
                }.disposed(by: weakSelf.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func makeAnnotations() -> [CLAnnotation] {
        var anns = [CLAnnotation]()
        
        for el in self.models.value {
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
