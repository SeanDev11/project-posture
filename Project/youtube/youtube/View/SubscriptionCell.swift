//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Sean Devine on 04.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed {  (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
    }
    
}
}
