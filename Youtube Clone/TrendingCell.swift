//
//  TrendingCell.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func loadData() {
        YoutubeService.getTrending {[weak self] in
            guard let slf = self else { return }
            slf.youtubeChanelDict = $0
            DispatchQueue.main.async {
                slf.collectionView.reloadData()
            }
        }
    }

}
