//
//  VideoCell.swift
//  YouTube
//
//  Created by MAC on 2/2/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import LBTAComponents

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            setThumbnailImage()
            setupProfileImage()
            
            if let channelName = video?.channel?.name,let numberOfViews = video?.number_of_views {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) - 2 years ago"
                subtitleTextView.text = subtitleText
            }
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsingURLString(urlString: profileImageUrl)
        }
    }
    
    func setThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingURLString(urlString: thumbnailImageUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - thumbnailImageView
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = #imageLiteral(resourceName: "taylon_swift_blank")
        
        // scale image cho vua
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - userProfileImageView
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "taylon_swift_profile")
        
        // vong tron
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    // MARK: - separatorView
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
    
    // MARK: - titleLabel
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tay lor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - subtitleLabel
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,604,604,607 views - 2 year ago ago ago ago"
        
        // làm mờ
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        thumbnailImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: userProfileImageView.topAnchor, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 8, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        separatorView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        userProfileImageView.anchor(thumbnailImageView.bottomAnchor, left: self.leftAnchor, bottom: separatorView.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 8, rightConstant: 10, widthConstant: 44, heightConstant: 44)
        
        titleLabel.anchor(thumbnailImageView.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 2, rightConstant: 10, widthConstant: 0, heightConstant: 15)
        
        subtitleTextView.anchor(titleLabel.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: separatorView.topAnchor, right: self.rightAnchor, topConstant: 2, leftConstant: 4, bottomConstant: 8, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
}
