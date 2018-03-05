//
//  SubcriptionsCell.swift
//  YouTube
//
//  Created by MAC on 3/4/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class SubcriptionCell: FeedCell {
    
    override func fetVideos() {
        ApiService.sharedInstance.fetchSubcriptionsFeed { [weak self] (videos) in
            guard let this = self else { return }
            this.videos = videos
            this.collectionView.reloadData()
        }
    }
}

