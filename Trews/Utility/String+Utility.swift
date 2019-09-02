//
//  String+Color.swift
//
//  Created by trungduc on 5/19/19.
//  Copyright © 2019 trungduc. All rights reserved.
//

import UIKit

extension String {
    
    var color: UIColor {
        return UIColor.fromHex(self)
    }

    var image: UIImage? {
        return UIImage(named: self)
    }
    
}
