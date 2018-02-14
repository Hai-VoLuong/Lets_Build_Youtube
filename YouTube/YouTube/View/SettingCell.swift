//
//  SettingCell.swift
//  YouTube
//
//  Created by MAC on 2/9/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import LBTAComponents

class Setting {
    
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

final class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            if let setting = setting {
                nameLabel.text = setting.name
                iconImageView.image = UIImage(named: setting.imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
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










