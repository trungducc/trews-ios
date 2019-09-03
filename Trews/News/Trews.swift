//
//  Trews.swift
//  Trews
//
//  Created by trungducc on 3/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import Foundation

class Trews {
    
    let id: UInt
    
    let title: String
    
    let creator: String
    
    let timeDifference: String
    
    init(id: UInt, title: String, creator: String, timeDifference: String) {
        self.id = id
        self.title = title
        self.creator = creator
        self.timeDifference = timeDifference
    }
    
}
