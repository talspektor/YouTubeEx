//
//  VideoLuancher.swift
//  YouTubeEx
//
//  Created by user140592 on 1/24/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit
import AVFoundation

class VideoLauncher: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showVideoPlayer()
    }
    
    func showVideoPlayer ()
    {
        let videoView = UIView(frame: view.frame)
        videoView.backgroundColor = .white
        
        videoView.frame = CGRect(x: view.frame.width - 10, y: view.frame.height - 10, width: 10, height: 10)
        
        //16 * 9 is the aspect ratio of all HD videos
        let height = view.frame.width * 9 / 16
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
        videoView.addSubview(videoPlayerView)
        
        view.addSubview(videoView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            videoView.frame = self.view.frame
            
        }) { (complitedAnimation) in
            UIApplication.shared.setStatusBarHidden(true, with: .fade)
        }
        
    }

}
