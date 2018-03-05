//
//  ApiService.swift
//  YouTube
//
//  Created by MAC on 3/1/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import Foundation

class ApiService {
    static let sharedInstance = ApiService()
    
    // ep14 16:44
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(url: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(url: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubcriptionsFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(url: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    private func fetchFeedForUrlString(url: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            do {
                if let data = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] {
                    DispatchQueue.main.async {
                        completion(jsonDictionaries.map({ return Video(dictionary: $0)}))
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
}
