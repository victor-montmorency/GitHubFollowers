//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 26/09/24.
//

import Foundation

enum GFError: String, Error{
    case invalidUsername = "This Username create an invalid request. Please try again"
    case invalidResponse = "User not found. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invadidData = "No data returned from the server. Please try again"
}
