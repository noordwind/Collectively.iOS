//
//  APIManager.swift
//  collectively
//
//  Created by Łukasz Bożek on 02/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import Foundation
import Alamofire
import p2_OAuth2
import RxSwift

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

typealias LoginResponse = (Bool, Error?) -> Void

class APIManager: NSObject {
    static let shared = APIManager()
    
    let base = "https://api.becollective.ly/"
    
    var alamo: Alamofire.SessionManager!
    var oauth2: OAuth2PasswordGrantModified!
    var loader: OAuth2DataLoader!
    
    static let auth = Authentication()
    static let map = MapElements()
    
    override init() {
        super.init()
        self.initOauth()
        self.initAlamofire()
        self.oauth2.logger = OAuth2DebugLogger(.debug)
        self.oauth2.verbose = true
        self.loader = OAuth2DataLoader(oauth2: oauth2)
    }
    
    fileprivate func initOauth() {
        self.oauth2 = OAuth2PasswordGrantModified(settings: [
            "username": "email",
//            "authorize_uri": base + token,
//            "token_uri": base + refresh,
            "scope": "read write",
            "secret_in_body": true,
            "keychain": true,
            ] as OAuth2JSON)
    }
    
    fileprivate func initAlamofire() {
        let sessionManager = SessionManager()
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        sessionManager.adapter = retrier
        sessionManager.retrier = retrier
        self.alamo = sessionManager
    }
    
}
