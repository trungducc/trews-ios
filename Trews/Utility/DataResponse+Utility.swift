//
//  DataResponse+Utility.swift
//  Trews
//
//  Created by Nguyen Duc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import Alamofire

extension DataResponse {
    
    func error() -> String? {
        guard let value = result.value as? [String: Any],
            let error = value["error"] as? [String: Any],
            let message = error["message"] as? String else {
            return nil
        }
        return message
    }
    
    func dictionaryData() -> [String: Any]? {
        guard let value = result.value as? [String: Any],
            let data = value["data"] as? [String: Any] else {
                return nil
        }
        return data
    }
    
    func arrayData() -> [[String: Any]]? {
        guard let value = result.value as? [String: Any],
            let data = value["data"] as? [[String: Any]] else {
                return nil
        }
        return data
    }
    
}
