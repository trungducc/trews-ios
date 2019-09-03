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
        
        static let gradientButtonCornerRadius: CGFloat = inputViewCornerRadius
        static let gradientButtonDisabledBackgroundColorAlpha: CGFloat = 0.5
    }
    
    enum Font {
        static let inputViewFont = UIFont.regularProTextFont(ofSize: 16)
        
        static let gradientButtonFont = UIFont.regularProTextFont(ofSize: 17)
        static let otherOptionsLabelFont = UIFont.mediumProTextFont(ofSize: 14)
        
        static let signUpButtonFont = UIFont.mediumProTextFont(ofSize: 15)
        
        static let trewsTitleFont = UIFont.regularProTextFont(ofSize: 12)
    }
    
    enum Strings {
        static let signIn = NSLocalizedString("Sign in", comment: "")
        static let signUp = NSLocalizedString("Sign up", comment: "")
        
        static let username = NSLocalizedString("Username", comment: "")
        static let password = NSLocalizedString("Password", comment: "")
        static let reenterPassword = NSLocalizedString("Re-enter password", comment: "")
        
        static let otherSignInOptions = NSLocalizedString("Or sign in with", comment: "")
        
        static let news = NSLocalizedString("News", comment: "")
        static let welcome = NSLocalizedString("Hey %@, what's on your mind?", comment: "")
        
        static let post = NSLocalizedString("Post", comment: "")
        static let yes = NSLocalizedString("Yes", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        
        static let signOut = NSLocalizedString("Sign out", comment: "")
        static let signOutMessage = NSLocalizedString("Do you want to sign out?", comment: "")
        
        static let recently = NSLocalizedString("Recently", comment: "")
        static let minutesAgo = NSLocalizedString(" minutes ago", comment: "")
        static let hoursAgo = NSLocalizedString(" hours ago", comment: "")
        static let daysAgo = NSLocalizedString(" days ago", comment: "")
        
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
        
        static let create = "create"
        static let signOut = "sign_out"
    }
    
    enum Color {
        static let primary = "ff0000"
        static let black = "1e2127"
        static let light = "b6bac2"
        
        static let navigationBarLargeTitle = "000000"
        static let viewControllerBackground = "fbfbfb"
        
        static let inputViewBorderColor = "e2e2e2"
        static let inputViewTextColor = black
        
        static let gradientButtonTextColor = "ffffff"
        static let gradientButtonDisabledBackgroundColor = "cfd3dc"
        
        static let gradientStartColor = "414345"
        static let gradientEndColor = "232526"
        
        static let otherOptionsLabelTextColor = black
        static let signUpButtonTextColor = "f96f6d"
    }

}
