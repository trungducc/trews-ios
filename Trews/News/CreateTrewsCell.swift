//
//  CreateTrewsCell.swift
//  Trews
//
//  Created by trungducc on 3/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

class CreateTrewsCell: UITableViewCell {
    
    private let containerView = UIView()
    private let welcomeLabel = UILabel()
    private let createImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public API
    
    func display(username: String?) {
        welcomeLabel.text = String(format: Constants.Strings.welcome, username ?? "")
    }
    
    // MARK: Private API
    
    private func setupSubviews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        containerView.backgroundColor = .white
        containerView.dropShadow(cornerRadius: 6)
        contentView.addSubview(containerView)
        
        welcomeLabel.font = UIFont.regularProTextFont(ofSize: 14)
        welcomeLabel.textColor = Constants.Color.light.color
        containerView.addSubview(welcomeLabel)
        
        createImageView.image = Constants.Image.create.image?.withRenderingMode(.alwaysTemplate)
        createImageView.contentMode = .scaleAspectFit
        createImageView.tintColor = welcomeLabel.textColor
        containerView.addSubview(createImageView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(createImageView.snp.leading).offset(8)
            make.centerY.equalToSuperview()
        }
        
        createImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
    }
    
}
