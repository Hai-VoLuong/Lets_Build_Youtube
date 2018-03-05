//
//  TrendingCell.swift
//  YouTube
//
//  Created by MAC on 3/4/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { [weak self] (videos) in
            guard let this = self else { return }
            this.videos = videos
            this.collectionView.reloadData()
        }
    }
}
