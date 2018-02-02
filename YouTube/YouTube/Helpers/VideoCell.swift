//
//  VideoCell.swift
//  YouTube
//
//  Created by MAC on 2/2/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import LBTAComponents

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoCell: BaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "taylon_swift_blank")
        
        // scale image cho vua
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "taylon_swift_profile")
        
        // vong tron
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tay lor Swift - Blank Space"
        return label
    }()
    
    let subtitleLabel: UITextView = {
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
        addSubview(subtitleLabel)
        
        thumbnailImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: userProfileImageView.topAnchor, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 8, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        separatorView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        userProfileImageView.anchor(thumbnailImageView.bottomAnchor, left: self.leftAnchor, bottom: separatorView.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 8, rightConstant: 10, widthConstant: 44, heightConstant: 44)
        
        titleLabel.anchor(thumbnailImageView.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 2, rightConstant: 10, widthConstant: 0, heightConstant: 15)
        
        subtitleLabel.anchor(titleLabel.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: separatorView.topAnchor, right: self.rightAnchor, topConstant: 2, leftConstant: 4, bottomConstant: 8, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
