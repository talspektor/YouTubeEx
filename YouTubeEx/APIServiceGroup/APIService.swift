//
//  APIService.swift
//  YouTubeEx
//
//  Created by user140592 on 1/12/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

class APIService: NSObject {

    
    static let shared = APIService()
    
    func fetchVideos(complition: @escaping ([Video]) -> ()) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            guard let data = data else { return }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String:Any]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String:Any]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                DispatchQueue.main.async {
                    complition(videos)
                }
                
                
            }catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    
    }
}
