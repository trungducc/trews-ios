//
//  AuthenticationButton.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

class AuthenticationButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private API
    
    private func commonInit() {
        layer.cornerRadius = Constants.Layout.authenticationButtonCornerRadius
        layer.masksToBounds = true
        
        titleLabel?.font = Constants.Font.authenticationButtonFont
        setTitleColor(Constants.Color.authenticationButtonTextColor.color, for: .normal)
        
        let disabledImage = UIImage(color: Constants.Color.authenticationButtonDisabledBackgroundColor.color.withAlphaComponent(Constants.Layout.authenticationButtonDisabledBackgroundColorAlpha))
        setBackgroundImage(disabledImage, for: .disabled)
        
        let enabledImage = UIImage(startColor: Constants.Color.authenticationButtonEnbledBackgroundStartColor.color, endColor: Constants.Color.authenticationButtonEnbledBackgroundEndColor.color)
        setBackgroundImage(enabledImage, for: .normal)
    }
    
}
