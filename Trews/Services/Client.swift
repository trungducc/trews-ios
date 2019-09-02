//
//  Client.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess

class Client {
    
    private static let baseUrl = "http://localhost:9009/"
    private static let headers: HTTPHeaders = ["Authorization": "Bearer \(token ?? "")"]
    
    private static let keychain = Keychain(service: "com.trungducc.trews")
    private static var token: String? {
        set {
            keychain["token"] = newValue
        }
        get {
            return keychain["token"]
        }
    }
    
    private var alamofire: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: config)
    }()
    
    // MARK: Public API
    
    func signIn(username: String, password: String, completion: @escaping (_ error: String?) -> Void) {
        let parameters = ["username": username,
                          "password": password]

        request("account/sign_in", method: .post, parameters: parameters).responseJSON { response in
            guard response.error == nil else {
                completion(Constants.Strings.Error.connectionError)
                return
            }
            
            if let data = response.data(), let token = data["token"] as? String {
                Client.token = token
                completion(nil)
            } else if let error = response.error() {
                completion(error)
            } else {
                completion(Constants.Strings.Error.internalServerError)
            }
        }
    }
    
    func signUp(username: String, password: String, completion: @escaping (_ error: String?) -> Void) {
        let parameters = ["username": username,
                          "password": password]
        
        request("account/sign_up", method: .post, parameters: parameters).responseJSON { response in
            guard response.error == nil else {
                    completion(Constants.Strings.Error.connectionError)
                    return
            }
            
            if let error = response.error() {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func listTrews(completion: @escaping (_ error: String?) -> Void) {
    }
    
    // MARK: Private API
    
    func request(_ uri: String,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 headers: HTTPHeaders? = nil) -> DataRequest {
        let encoding: ParameterEncoding
        switch method {
        case .get: encoding = URLEncoding.queryString
        default: encoding = JSONEncoding.default
        }
        
        return alamofire.request(Client.baseUrl + uri,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers ?? Client.headers)
    }
    
}
