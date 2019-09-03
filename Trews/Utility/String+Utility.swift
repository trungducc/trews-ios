//
//  String+Color.swift
//
//  Created by trungduc on 5/19/19.
//  Copyright © 2019 trungduc. All rights reserved.
//

import UIKit

extension String {
    
    static func from(timeDifference: TimeInterval) -> String {
        if timeDifference < 60 {
            return Constants.Strings.recently
        } else if timeDifference < 3600 {
            return "\(Int(timeDifference / 60))" + Constants.Strings.minutesAgo
        } else if timeDifference < 86400 {
            return "\(Int(timeDifference / 3600))" + Constants.Strings.hoursAgo
        }
        return "\(Int(timeDifference / 86400))" + Constants.Strings.daysAgo
    }
    
    var color: UIColor {
        return UIColor.fromHex(self)
    }

    var image: UIImage? {
        return UIImage(named: self)
    }
    
    func width(for height: CGFloat, with font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func isValidUsername() -> Bool {
        return self.count > 2
    }
    
    func isValidPassword() -> Bool {
        return self.count > 2
    }
    
}
