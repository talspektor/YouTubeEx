
//
//  Video.swift
//  YouTubeEx
//
//  Created by user140592 on 1/8/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSData?
    var channel: Channel?
        
}

class Channel: NSObject {
    var name:String?
    var profileImageName: String?
}
