//
//  Enums&Structs.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 29/04/23.
//

import Foundation

///field within user document.
struct DatabaseUserField {
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userId = "user_id"
    static let bio = "bio"
    static let dateCreated  = "date_created"
}

struct UserDefaultsFields {
    static let displayName = "display_name"
    static let userId = "user_id"
    static let bio = "bio"
}

//Field within post document
struct DatabasePostField {
    static let postID = "post_id"
    static let displayName = "display_name"
    static let userId = "user_id"
    static let caption = "caption"
    static let dateCreated  = "date_created"
    static let likeCount = "like_count" //Int
    static let likedBy = "liked_by" //Array of Users!
    static let comments = "comments" //Sub collection
}

struct DatabaseReportField {
    static let content = "content"
    static let postID = "post_id"
    static let dateCreated = "date_created"
}

struct DatabaseCommentsField {
    static let commentID = "comment_id"
    static let displayName = "display_name"
    static let userId = "user_id"
    static let content = "content"
    static let dateCreated = "date_created"
}

enum SettingsEditTextOptions {
    case displayName, bio
}
