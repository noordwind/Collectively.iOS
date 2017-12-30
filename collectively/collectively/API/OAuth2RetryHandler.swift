//
//  OAuth2RetryHandler.swift
//  Electorate
//
//  Created by Łukasz Bożek on 18/12/2017.
//  Copyright © 2017 espeo. All rights reserved.
//

import Foundation
import p2_OAuth2
import Alamofire


class OAuth2RetryHandler: RequestRetrier, RequestAdapter {
    
    let loader: OAuth2DataLoader
    let oauth2: OAuth2!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init(oauth2: OAuth2) {
        loader = OAuth2DataLoader(oauth2: oauth2)
        self.oauth2 = oauth2
    }
    
    /// Intercept 401 and do an OAuth2 authorization.
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
        
        if let response = request.task?.response as? HTTPURLResponse, 401 == response.statusCode, let req = request.request {
            
            if(request.retryCount > 1){
                if(self.oauth2.hasUnexpiredAccessToken()){
                    //clear tokens as they are revoked most likely
                    DispatchQueue.main.async {
                        //logout
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.logout()
                        completion(true, 0.0)
                        return
                    }
                }
            }
            var dataRequest = OAuth2DataRequest(request: req, callback: { _ in })
            dataRequest.context = completion
            loader.enqueue(request: dataRequest)
            loader.attemptToAuthorize() { authParams, error in
                self.loader.dequeueAndApply() { req in
                    if let comp = req.context as? RequestRetryCompletion {
                        comp(nil != authParams, 0.0)
                    }
                }
            }
        }
        else {
            completion(false, 0.0)   // not a 401, not our problem
        }
    }
    
    /// Sign the request with the access token.
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard nil != loader.oauth2.accessToken else {
            return urlRequest
        }
        return try urlRequest.signed(with: loader.oauth2)
    }
}

class OAuth2PasswordGrantModified: OAuth2PasswordGrant {
    override func assureCorrectBearerType(_ params: OAuth2JSON) throws {
        if ((params["access"] as? String) != nil) {
            return
        }
        throw OAuth2Error.noTokenType
    }
    
    override func normalizeAccessTokenResponseKeys(_ dict: OAuth2JSON) -> OAuth2JSON {
        let d: OAuth2JSON = [
            "access_token": dict["access"] ?? "",
            "refresh_token": dict["refresh"] ?? ""
        ]
        return d
    }
    
    override func accessTokenRequest(params: OAuth2StringDict? = nil) throws -> OAuth2AuthRequest {
        if username?.isEmpty ?? true {
            throw OAuth2Error.noUsername
        }
        if password?.isEmpty ?? true {
            throw OAuth2Error.noPassword
        }
        
        let req = OAuth2AuthRequest(url: (clientConfig.tokenURL ?? clientConfig.authorizeURL))
        req.params["grant_type"] = type(of: self).grantType
        req.params["email"] = username
        req.params["password"] = password
        if let clientId = clientConfig.clientId {
            req.params["client_id"] = clientId
        }
        if let scope = clientConfig.scope {
            req.params["scope"] = scope
        }
        req.add(params: params)
        
        return req
    }
    
    override func request(forURL url: URL, cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalCacheData) -> URLRequest {
        var req = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 20)
        try? req.sign(with: self)
        return req
    }
}

