//
//  VideoCell.swift
//  YouTubeEx
//
//  Created by user140592 on 1/6/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            if let channelName = video?.channel?.name,
               let number_of_views = video?.number_of_views{
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let formatedNumberOfViews = numberFormatter.string(from: NSNumber(value: number_of_views))!
                let subtitleText = "\(channelName) - \(formatedNumberOfViews) - 2 years ago"
                subTitleTextView.text = subtitleText
            }
  
            // Measore title tet
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let font = UIFont.systemFont(ofSize: 14)
                let estimatedRect = NSString(string: title).boundingRect(with: size,
                                                                         options: options,
                                                                         attributes: [.font: font],
                                                                         context: nil)
//                
//
//                if estimatedRect.size.height > 20 {
//                    titleLabelHeightConstraing?.constant = 44
//                } else {
//                    titleLabelHeightConstraing?.constant = 20
//                }
            }

        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "taylorSwiftBlankSpase")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "taylorSwiftThumbNamil")
        imageView.layer.cornerRadius = 22
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is some text to fill the title"
        label.numberOfLines = 0
        return label
    }()
    
    let subTitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "This video has 1,000,001 views - 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    var titleLabelHeightConstraing: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        titleLabelHeightConstraing = titleLabel.heightAnchor.constraint(equalToConstant: 44)
        NSLayoutConstraint.activate([
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            thumbnailImageView.bottomAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: -8),
            
            userProfileImageView.heightAnchor.constraint(equalToConstant: 44),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 44),
            userProfileImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 0),
            userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),

            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0),
            titleLabelHeightConstraing!,
            
            subTitleTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            subTitleTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
            subTitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleTextView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -36),
            subTitleTextView.heightAnchor.constraint(equalToConstant: 22)
            ])
        
    }
}
