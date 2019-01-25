
//
//  Video.swift
//  YouTubeEx
//
//  Created by user140592 on 1/8/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

struct Video: Decodable {
    
    let thumbnail_image_name: String?
    let title: String?
    let number_of_views: Int?
    let duration: Int?
    let uploadDate: Data?
    let channel: Channel?
    
}

struct Channel: Decodable {
    let name:String?
    let profileImageName: String?
}
