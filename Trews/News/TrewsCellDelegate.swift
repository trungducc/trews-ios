//
//  TrewsCellDelegate.swift
//  Trews
//
//  Created by Nguyen Duc on 4/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import Foundation

protocol TrewsCellDelegate: class {
    
    func likeButtonDidTouch(cell: TrewsCell)
    
    func dislikeButtonDidTouch(cell: TrewsCell)
    
}
