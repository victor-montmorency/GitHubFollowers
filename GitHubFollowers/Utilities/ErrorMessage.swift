//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 26/09/24.
//

import Foundation

enum ErrorMessage: String{
    case invalidUsername = "This Username create an invalid request. Please try again"
    case invalidServerResponse = "Invalid response from the server. Please try again"
    case unableToCompleteRequest = "Unable to complete your request. Please check your internet connection."
    case noDataReturnedFromServer = "No data returned from the server. Please try again"
}
