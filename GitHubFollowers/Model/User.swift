//
//  User.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 25/09/24.
//

import Foundation

struct User: Codable{
    let login: String
    let avatarUrl: URL
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
