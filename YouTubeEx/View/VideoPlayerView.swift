//
//  VideoPlayerView.swift
//  YouTubeEx
//
//  Created by user140592 on 1/26/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var panGesture = UIPanGestureRecognizer()
    
    let activityIndecatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause-button")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = false
    
    @objc func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "player-play"), for: .normal)
        }else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause-button"), for: .normal)
            
        }
        isPlaying = !isPlaying
    }
    
    lazy var controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "red-ball"), for: .normal)
        slider.thumbTintColor = .red
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * Float64(totalSeconds)
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }
        
    }
    
    private func addSubViews() {
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndecatorView)
        controlsContainerView.addSubview(pausePlayButton)
        controlsContainerView.addSubview(videoLengthLabel)
        controlsContainerView.addSubview(currentTimeLabel)
        controlsContainerView.addSubview(videoSlider)
    }
    
    private func setConstraints() {
        activityIndecatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndecatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        videoLengthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24)
        
        currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        videoSlider.trailingAnchor.constraint(equalTo: videoLengthLabel.leadingAnchor, constant: 0).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor, constant: 0).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(panGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        setupGradiantLayer()
        
        controlsContainerView.frame = frame
        addSubViews()
        setConstraints()
        setGesture()
        backgroundColor = .black
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer) {
        guard let view = self.superview else {return}
        view.bringSubviewToFront(self)
        let translation = sender.translation(in: view)
        if center == CGPoint(x: center.x, y: (UIApplication.shared.keyWindow?.bounds.height)! - center.y) {
            removeGestureRecognizer(panGesture)
        }else {
            center = CGPoint(x: center.x, y: center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    var player: AVPlayer?
    
    private func setupPlayerView() {
        
        let urlString = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            //track player progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
                let secondsFormatedText = String(format: "%02d", secondsText)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                
                self.currentTimeLabel.text = "\(minutesText):\(secondsFormatedText)"
                
                // move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(Float64(seconds / durationSeconds))
                }
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and randering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndecatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration{
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
                let secondsFormatedText = String(format: "%02d", secondsText)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsFormatedText)"
            }
        }
    }
    
    private func setupGradiantLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
