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
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                // 27 phut
                var videos = [Video]()
                
                for dictinary in (json as! [[String: AnyObject]]) {
                    let video = Video()
                    video.title = dictinary["title"] as? String
                    video.thumbnailImageName = dictinary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictinary["channel"] as? [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary!["name"] as? String
                    channel.profileImageName = channelDictionary!["profile_image_name"] as?
                    String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                DispatchQueue.main.async {
                    completion(videos)
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
}
