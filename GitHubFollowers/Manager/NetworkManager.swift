//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 25/09/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GFError>) -> Void) {
        let endPoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invadidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                
                completed(.failure(.invadidData))
            }
            
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, completed: @escaping(Result<User, GFError>) -> Void) {
        let endPoint = baseURL + username
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invadidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                
                completed(.failure(.invadidData))
            }
            
        }
        task.resume()
    }
}
