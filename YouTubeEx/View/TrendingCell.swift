//
//  TrendingCellCollectionViewCell.swift
//  YouTubeEx
//
//  Created by user140592 on 1/20/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        APIService.shared.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
