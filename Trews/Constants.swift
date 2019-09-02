//
//  Constants.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

enum Constants {
    
    enum Layout {
        static let inputViewCornerRadius: CGFloat = 7
        
        static let authenticationButtonCornerRadius: CGFloat = inputViewCornerRadius
        static let authenticationButtonDisabledBackgroundColorAlpha: CGFloat = 0.5
    }
    
    enum Font {
        static let inputViewFont = UIFont.regularProTextFont(ofSize: 16)
        
        static let authenticationButtonFont = UIFont.regularProTextFont(ofSize: 17)
        static let otherOptionsLabelFont = UIFont.mediumProTextFont(ofSize: 14)
        
        static let signUpButtonFont = UIFont.mediumProTextFont(ofSize: 15)
    }
    
    enum Strings {
        static let signIn = NSLocalizedString("Sign in", comment: "")
        static let signUp = NSLocalizedString("Sign up", comment: "")
        
        static let username = NSLocalizedString("Username", comment: "")
        static let password = NSLocalizedString("Password", comment: "")
        static let reenterPassword = NSLocalizedString("Re-enter password", comment: "")
        
        static let otherSignInOptions = NSLocalizedString("Or sign in with", comment: "")
        
        static let news = NSLocalizedString("News", comment: "")
        
        enum Error {
            static let connectionError = NSLocalizedString("Connection error", comment: "")
            static let internalServerError = NSLocalizedString("Internal Server Error", comment: "")
        }
    }
    
    enum Image {
        static let securityOn = "security_on"
        static let securityOff = "security_off"
        
        static let facebook = "facebook"
        static let google = "google"
    }
    
    enum Color {
        static let primary = "ff0000"
        
        static let navigationBarLargeTitle = "000000"
        static let viewControllerBackground = "fbfbfb"
        
        static let inputViewBorderColor = "e2e2e2"
        static let inputViewTextColor = "1e2127"
        
        static let authenticationButtonTextColor = "ffffff"
        static let authenticationButtonDisabledBackgroundColor = "cfd3dc"
        
        static let authenticationButtonEnbledBackgroundStartColor = "414345"
        static let authenticationButtonEnbledBackgroundEndColor = "232526"
        
        static let otherOptionsLabelTextColor = "1e2127"
        static let signUpButtonTextColor = "f96f6d"
    }

}
