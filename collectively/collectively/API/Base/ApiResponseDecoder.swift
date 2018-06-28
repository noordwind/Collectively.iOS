//
//  ApiResponseDecoder.swift
//  popular wikis list
//
//  Created by Łukasz Bożek on 18/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

protocol ApiResponseDecoder {
    func decode(_ data: Data?) -> Any?
}

class ApiResponseDefaultDecoder: ApiResponseDecoder {
    func decode(_ data: Data?) -> Any? {
        return data
    }
}

class ApiResponseJSONDecoder<Model: Decodable>: ApiResponseDecoder {
    func decode(_ data: Data?) -> Any? {
        guard let data = data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        return try? decoder.decode(Model.self, from: data)
    }
}
