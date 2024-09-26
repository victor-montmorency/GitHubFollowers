//
//  Follower.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 25/09/24.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: String
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
