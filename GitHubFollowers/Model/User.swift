//
//  User.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 25/09/24.
//

import Foundation

struct User: Codable{
    var login: String
    let avatarUrl: URL
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
