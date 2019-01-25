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
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(complition: @escaping ([Video]) -> ())
    {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", complition: complition)
    }
    
    func fetchTrendingFeed (complition: @escaping ([Video]) -> ())
    {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", complition: complition)
    }
    
    func fetchSubscriptionFeed (complition: @escaping ([Video]) -> ())
    {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", complition: complition)
    }
    
    func fetchFeedForUrlString (urlString: String, complition: @escaping ([Video]) -> ())
    {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            guard let data = data else { return }
            
            do {
                let videos:[Video] = try JSONDecoder().decode([Video].self,from: data)

                DispatchQueue.main.async {
                    complition(videos)
                }
                
            }catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
}


