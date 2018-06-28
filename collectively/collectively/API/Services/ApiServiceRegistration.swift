//
//  ApiServiceRegistration.swift
//  collectively
//
//  Created by Łukasz Bożek on 28/06/2018.
//  Copyright © 2018 collectively. All rights reserved.
//

import Foundation

struct RegistrationApiResponse: Codable {
    let success: Bool
}

class ApiServiceRegistration: BaseApiService {
    override var requestUrl: String? {
        return "sign-up"
    }
    
    override var parameters: [String : Any]? {
        return ["email": email,
                "name": username,
                "password": password,
                "provider": "collectively"]
    }
    
    private let email: String
    private let username: String
    private let password: String
    
    init(username: String, email: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
        super.init()
        self.method = .post
        decoder = ApiResponseJSONDecoder<RegistrationApiResponse>()
    }
}
