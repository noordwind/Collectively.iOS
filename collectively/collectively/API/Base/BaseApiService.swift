//
//  BaseApiService.swift
//  popular wikis list
//
//  Created by Łukasz Bożek on 18/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation
import Alamofire

enum ApiServiceMethod: String {
    case GET
    case POST
}

class BaseApiService: ApiService {
    
    // MARK: - Public properties
    
    var success: ApiServiceSuccess?
    var failure: ApiServiceFailure?
    var method = HTTPMethod.get
    lazy var decoder: ApiResponseDecoder = ApiResponseDefaultDecoder()
    
    var requestUrl: String? {
        return ""
    }
    
    var parameters: [String: Any]? {
        return [:]
    }
    
    // MARK: - Private properties
    
    private var task: URLSessionTask?
    private lazy var session = URLSession.shared
    
    // MARK: - Public methods
    
    func start() {
        guard let urlRequest = request() else {
            return
        }
        
        APIManager.shared.alamo.request(urlRequest,
                                        method: method,
                                        parameters: parameters,
                                        encoding: JSONEncoding.default)
            .responseJSON { response in
                if let error = response.error {
                    self.failure?(error)
                } else if let decodedData = self.decoder.decode(response.data) {
                    self.success?(decodedData)
                } else {
                    self.failure?(ApiErrorsFactory.makeError(for: .invalidResponse))
                }
        }
        
//        task = session.dataTask(with: urlRequest) { [weak self] (data, _, error) in
//            DispatchQueue.main.async {
//                guard let strongSelf = self else { return }
//
//                if let error = error {
//                    strongSelf.failure?(error)
//                } else if let decodedData = strongSelf.decoder.decode(data) {
//                    strongSelf.success?(decodedData)
//                } else {
//                    strongSelf.failure?(ApiErrorsFactory.makeError(for: .invalidResponse))
//                }
//            }
//
//        }
//
//        task?.resume()
    }
    
    // MARK: - Private methods
    
    private func request() -> String? {
        guard let urlString = requestUrl else {
            return nil
        }
        
        let url = Environment.baseUrl + urlString
        
        return url
    }
}
