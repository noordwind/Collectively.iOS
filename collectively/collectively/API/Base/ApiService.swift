//
//  ApiService.swift
//  popular wikis list
//
//  Created by Łukasz Bożek on 18/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

typealias ApiServiceSuccess = ((Any?) -> Void)
typealias ApiServiceFailure = ((Error) -> Void)

protocol ApiService {
    var success: ApiServiceSuccess? { get set }
    var failure: ApiServiceFailure? { get set }
    
    func start()
    func restart()
}

extension ApiService {
    func restart() {
        start()
    }
}
