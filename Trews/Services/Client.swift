//
//  Client.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import Foundation
import Alamofire

class Client {
    
    static let shared = Client()
    
    private static let baseUrl = "http://localhost:9009/"
    private static let headers: HTTPHeaders = ["AUTHORIZATION": "Bearer TODO"]
    
    private var alamofire: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: config)
    }()
    
    // MARK: Public API
    
    func signIn(username: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        let parameters = ["username": username,
                          "password": password]
        request("account/sign_in", method: .post, parameters: parameters).responseJSON { response in
            guard let value = response.result.value as? [String: Any],
                  let data = value["data"] as? [String: Any],
                  let token = data["token"] else {
                completion(false)
                return
            }
            print(token)
            completion(true)
        }
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
