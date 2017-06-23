//
//  YoutubeModel.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/20/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class YoutubeModel {
    var title: String?
    var thumbnailImage: String?
    var channelName: String?
    var duration: String?
    var numberOfViews: String?
    var profileImage: String?
    
    
    func loadDescriptionFromPayload(_ payload: JSONDictType) {
        
        if let channel = payload["channel"] as? [String : String],
            let imageName = channel["profile_image_name"], let chName = channel["name"] {
            profileImage = imageName
            channelName = chName
        }
        if let dur = payload["duration"] as? Int {
            duration = "\(dur/60)"
        }
        if let numViews = payload["number_of_views"] as? Int {
            numberOfViews = "\(numViews)"
        }
        if let thumbImage = payload["thumbnail_image_name"] as? String {
            thumbnailImage = thumbImage
        }
        if let tit = payload["title"] as? String {
            title = tit
        }
    }
}
