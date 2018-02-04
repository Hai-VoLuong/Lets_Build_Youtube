//
//  Video.swift
//  YouTube
//
//  Created by MAC on 2/4/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class Video {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel {
    var name: String?
    var profileImageName: String?
}
