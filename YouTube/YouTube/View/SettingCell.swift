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
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
