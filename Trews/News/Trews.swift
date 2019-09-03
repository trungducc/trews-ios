//
//  Trews.swift
//  Trews
//
//  Created by trungducc on 3/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import Foundation

enum ReactionType: Int {
    case none = 0, like, dislike
}

class Trews {
    
    let id: UInt
    let title: String
    let creator: String
    let timeDifference: String
    var likeCount: UInt
    var dislikeCount: UInt
    var reactionType: ReactionType
    
    init(id: UInt, title: String, creator: String, timeDifference: String, likeCount: UInt, dislikeCount: UInt, reactionType: ReactionType) {
        self.id = id
        self.title = title
        self.creator = creator
        self.timeDifference = timeDifference
        self.likeCount = likeCount
        self.dislikeCount = dislikeCount
        self.reactionType = reactionType
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? UInt,
            let title = dictionary["title"] as? String,
            let creator = dictionary["user"] as? [String: Any],
            let creatorName = creator["username"] as? String,
            let createdDate = dictionary["created_date"] as? TimeInterval,
            let likeCount = dictionary["like_count"] as? UInt,
            let dislikeCount = dictionary["dislike_count"] as? UInt,
            let reactionType = dictionary["reaction_type"] as? Int else {
            return nil
        }
        let timeDifference = String.from(timeDifference: Date().timeIntervalSince1970 - createdDate / 1000)
        self.init(id: id,
                  title: title,
                  creator: creatorName,
                  timeDifference: timeDifference,
                  likeCount: likeCount,
                  dislikeCount: dislikeCount,
                  reactionType: ReactionType(rawValue: reactionType) ?? .none)
    }
    
}
