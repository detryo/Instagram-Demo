//
//  Models.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 15/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation

public enum UserPostType {
    case photo, video
}

/// Represent a user post
public struct UserPost {
    
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}

struct PostLike {
    
    let userName: String
    let postIdentifier: String
}

struct CommentLike {
    
    let userName: String
    let commentIdentifier: String
}

struct PostComment {
    
    let identifier: String
    let userName: String
    let text: String
    let createdDate: Date
    let like: [CommentLike]
}

struct User {
    
    let userName: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let joinDate: Date
    let gender: Gender
    let count: UserCount
}

struct UserCount {
    
    let followers: Int
    let following: Int
    let post: Int
}

enum Gender {
    
    case male, famale, other
}
