//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 25/09/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping([Follower]?, String?) -> Void) {
        let endPoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            let errorMessage = ErrorMessage.invalidUsername.rawValue
            completed(nil, errorMessage)
            return
        }
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                let errorMessage = ErrorMessage.unableToCompleteRequest.rawValue
                completed(nil, errorMessage)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, ErrorMessage.invalidServerResponse.rawValue)
                return
            }
            
            guard let data = data else {
                let errorMessage = ErrorMessage.noDataReturnedFromServer.rawValue
                completed(nil, errorMessage)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                
                completed(nil, ErrorMessage.noDataReturnedFromServer.rawValue)
            }
            
        }
        task.resume()
    }
}
