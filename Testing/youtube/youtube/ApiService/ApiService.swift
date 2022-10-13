//
//  ApiService.swift
//  youtube
//
//  Created by Sean Devine on 02.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        
        fetchFeedForUrlString(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json", completion: completion)
        
    }
    

    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        
        fetchFeedForUrlString(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json", completion: completion)
        
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        
        fetchFeedForUrlString(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json", completion: completion)
        
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ())
    {
        let url: URL = URL(string: urlString)!
        URLSession.shared.dataTask(with: url ) { (data, respone, error) in
            
            if error != nil {
                print(error)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
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
