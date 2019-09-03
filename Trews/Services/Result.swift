//
//  Result.swift
//  Trews
//
//  Created by trungducc on 3/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

public enum Result<Value> {
    case success(Value)
    case failure(String)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: String? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
