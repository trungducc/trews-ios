//
//  TrewsCell.swift
//  Trews
//
//  Created by trungducc on 3/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit
import SnapKit

class TrewsCell: UITableViewCell {
    
    private static let creatorBackgroundImage = UIImage(startColor: Constants.Color.gradientStartColor.color,
                                                        endColor: Constants.Color.gradientEndColor.color,
                                                        size: CGSize(width: 100, height: 20))
    
    weak var delegate: TrewsCellDelegate?
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let creatorBackgroundImageView = UIImageView()
    private let creatorLabel = UILabel()
    private let timeLabel = UILabel()
    private let likeButton = ReactionButton()
    private let dislikeButton = ReactionButton()
    
    private var creatorLabelWidthConstraint: Constraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.isSelected = false
        dislikeButton.isSelected = false
    }
    
    // MARK: Public API
    
    func display(trews: Trews) {
        titleLabel.text = trews.title
        creatorLabel.text = trews.creator
        timeLabel.text = String(format: "%@", trews.timeDifference)
        likeButton.reactionCount = trews.likeCount
        dislikeButton.reactionCount = trews.dislikeCount
        
        switch trews.reactionType {
        case .like:
            likeButton.isSelected = true
            dislikeButton.isSelected = false
        case .dislike:
            dislikeButton.isSelected = true
            likeButton.isSelected = false
        default:
            likeButton.isSelected = false
            dislikeButton.isSelected = false
        }
        
        creatorLabel.snp.updateConstraints { make in
            make.width.equalTo(trews.creator.width(for: creatorLabel.frame.height, with: creatorLabel.font))
        }
    }
    
    // MARK: Private API
    
    private func setupSubviews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        containerView.backgroundColor = .white
        containerView.dropShadow(cornerRadius: 6)
        contentView.addSubview(containerView)
        
        creatorBackgroundImageView.image = TrewsCell.creatorBackgroundImage
        creatorBackgroundImageView.layer.cornerRadius = 10
        creatorBackgroundImageView.layer.masksToBounds = true
        containerView.addSubview(creatorBackgroundImageView)
        
        creatorLabel.textColor = .white
        creatorLabel.font = UIFont.semiboldProTextFont(ofSize: 13)
        containerView.addSubview(creatorLabel)
        
        timeLabel.textColor = Constants.Color.light.color
        timeLabel.font = UIFont.mediumProTextFont(ofSize: 12)
        containerView.addSubview(timeLabel)
        
        titleLabel.font = Constants.Font.trewsTitleFont
        titleLabel.textColor = Constants.Color.black.color
        titleLabel.numberOfLines = 0
        containerView.addSubview(titleLabel)
        
        likeButton.reactionImage = Constants.Image.like.image
        likeButton.addTarget(self, action: #selector(likeButtonDidTouch), for: .touchUpInside)
        containerView.addSubview(likeButton)
        
        dislikeButton.reactionImage = Constants.Image.dislike.image
        dislikeButton.addTarget(self, action: #selector(dislikeButtonDidTouch), for: .touchUpInside)
        containerView.addSubview(dislikeButton)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        creatorBackgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(creatorLabel)
            make.bottom.equalTo(creatorLabel)
            make.leading.equalTo(creatorLabel).offset(-7)
            make.trailing.equalTo(creatorLabel).offset(7)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(13)
            make.top.equalToSuperview().offset(6)
            make.width.equalTo(0)
            make.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(creatorLabel.snp.bottom).offset(6)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
            make.size.equalTo(CGSize(width: 44, height: 20))
        }
        
        dislikeButton.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(4)
            make.size.equalTo(likeButton)
            make.centerY.equalTo(likeButton)
        }
    }
    
    @objc private func likeButtonDidTouch() {
        delegate?.likeButtonDidTouch(cell: self)
    }
    
    @objc private func dislikeButtonDidTouch() {
        delegate?.dislikeButtonDidTouch(cell: self)
    }
    
}
