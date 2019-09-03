//
//  GradientButton.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

class GradientButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private API
    
    private func commonInit() {
        layer.cornerRadius = Constants.Layout.gradientButtonCornerRadius
        layer.masksToBounds = true
        
        titleLabel?.font = Constants.Font.gradientButtonFont
        setTitleColor(Constants.Color.gradientButtonTextColor.color, for: .normal)
        
        let disabledImage = UIImage(color: Constants.Color.gradientButtonDisabledBackgroundColor.color.withAlphaComponent(Constants.Layout.gradientButtonDisabledBackgroundColorAlpha))
        setBackgroundImage(disabledImage, for: .disabled)
        
        let enabledImage = UIImage(startColor: Constants.Color.gradientStartColor.color, endColor: Constants.Color.gradientEndColor.color)
        setBackgroundImage(enabledImage, for: .normal)
    }
    
}
