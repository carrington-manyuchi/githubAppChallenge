//
//  OldWayNetworkManager.swift
//  GitHubApp
//
//  Created by Manyuchi, Carrington C on 2024/06/28.
//

import Foundation

class OldWayNetworkManager {

        static let shared = OldWayNetworkManager()
        let baseURL = "https://api.github.com/users/"
        
        private init() {}
        
        func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
              let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
            
            guard let url = URL(string: endpoint) else {
                completed(nil, .invalidUsername)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completed(nil, .unableToComplete)
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(nil, .invalidResponse)
                    return
                }
                
                guard let data = data else {
                    completed(nil, .invalidData)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let followers = try decoder.decode([Follower].self, from: data)
                    completed(followers, nil)
                } catch {
                    completed(nil, .invalidData)
                }
            }
            task.resume()
        }
    }
