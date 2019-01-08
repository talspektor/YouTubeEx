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
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "image4")
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
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "image3")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is some text to fill the title"
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
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            thumbnailImageView.bottomAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: -8),
            
            userProfileImageView.heightAnchor.constraint(equalToConstant: 44),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 44),
            userProfileImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 0),
            userProfileImageView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -16),
            
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),

            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            subTitleTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            subTitleTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
            subTitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleTextView.heightAnchor.constraint(equalToConstant: 20)
            ])
        
    }
}
