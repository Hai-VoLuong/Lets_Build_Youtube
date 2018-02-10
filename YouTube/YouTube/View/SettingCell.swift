//
//  SettingCell.swift
//  YouTube
//
//  Created by MAC on 2/9/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import LBTAComponents

final class SettingCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        nameLabel.anchor(topAnchor, left: iconImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        iconImageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nameLabel.leftAnchor, topConstant: 8, leftConstant: 25, bottomConstant: 8, rightConstant: 25, widthConstant: 5, heightConstant: 5)
    }
}










