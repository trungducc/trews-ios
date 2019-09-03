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
    
    private static let baseUrl = "http://localhost:9000/"
    private static let keychain = Keychain(service: "com.trungducc.trews")

    private var headers: HTTPHeaders {
        return ["Authorization": "Bearer \(Client.keychain["token"] ?? "")"]
    }

    private var token: String? {
        set {
            Client.keychain["token"] = newValue
        }
        get {
            return Client.keychain["token"]
        }
    }
    
    private(set) var username: String? {
        set {
            Client.keychain["username"] = newValue
        }
        get {
            return Client.keychain["username"]
        }
    }
    
    private var alamofire: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: config)
    }()
    
    var isAuthorized: Bool {
        return token != nil
    }
    
    // MARK: Public API
    
    func signIn(username: String, password: String, completion: @escaping (_ error: String?) -> Void) {
        let parameters = ["username": username,
                          "password": password]

        request("account/sign_in", method: .post, parameters: parameters).responseJSON { response in
            guard response.error == nil else {
                completion(Constants.Strings.Error.connectionError)
                return
            }
            
            if let data = response.dictionaryData(), let token = data["token"] as? String {
                self.token = token
                self.username = username
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
    
    func signOut(completion: @escaping (_ error: String?) -> Void) {
        token = nil
        username = nil
        completion(nil)
    }
    
    func listTrews(completion: @escaping (_ result: Result<[Trews]>) -> Void) {
        request("trews/list", method: .get).responseJSON { response in
            guard response.error == nil else {
                completion(.failure(Constants.Strings.Error.connectionError))
                return
            }
            
            if let error = response.error() {
                completion(.failure(error))
                return
            }
            
            guard let data = response.arrayData() else {
                completion(.failure(Constants.Strings.Error.internalServerError))
                return
            }
            
            var trews = [Trews]()
            let now = Date().timeIntervalSince1970
            
            for dictionary in data {
                if let id = dictionary["id"] as? UInt,
                    let title = dictionary["title"] as? String,
                    let creator = dictionary["user"] as? [String: Any],
                    let creatorName = creator["username"] as? String,
                    let createdDate = dictionary["created_date"] as? TimeInterval {
                    let timeDifference = String.from(timeDifference: now - createdDate / 1000)
                    let newTrews = Trews(id: id, title: title, creator: creatorName, timeDifference: timeDifference)
                    trews.append(newTrews)
                }
            }
            completion(.success(trews))
        }
    }
    
    public func createTrews(title: String, completion: @escaping (_ error: String?) -> Void) {
        let parameters = ["title": title]
        
        request("trews/create", method: .post, parameters: parameters).responseJSON { response in
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
                                 headers: headers ?? self.headers)
    }
    
}
