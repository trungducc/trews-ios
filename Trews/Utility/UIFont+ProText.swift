//
//  UIFont+ProText.swift
//  Trews
//
//  Created by Nguyen Duc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func regularProTextFont(ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProText-Regular", size: fontSize) else {
            fatalError("Can't load font")
        }
        return font
    }
    
    static func mediumProTextFont(ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProText-Medium", size: fontSize) else {
            fatalError("Can't load font")
        }
        return font
    }
    
    static func semiboldProTextFont(ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProText-Semibold", size: fontSize) else {
            fatalError("Can't load font")
        }
        return font
    }
    
    static func boldProTextFont(ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProText-Bold", size: fontSize) else {
            fatalError("Can't load font")
        }
        return font
    }
    
}
