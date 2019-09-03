//
//  ReactionButton.swift
//  Trews
//
//  Created by trungducc on 4/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

class ReactionButton: UIButton {
    
    var reactionImage: UIImage? {
        didSet {
            reactionImageView.image = reactionImage
        }
    }
    var reactionCount: UInt = 0 {
        didSet {
            reactionCountLabel.text = String(reactionCount)
        }
    }
    
    private let reactionImageView = UIImageView()
    private let reactionCountLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private API
    
    private func commonInit() {
        reactionImageView.contentMode = .scaleAspectFit
        reactionImageView.image = reactionImage
        addSubview(reactionImageView)
        
        reactionCountLabel.font = UIFont.mediumProTextFont(ofSize: 15)
        reactionCountLabel.textColor = Constants.Color.black.color
        reactionCountLabel.textColor = Constants.Color.light.color
        addSubview(reactionCountLabel)
        
        reactionImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(snp.height)
        }
        
        reactionCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(reactionImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(1)
        }
    }
    
}
