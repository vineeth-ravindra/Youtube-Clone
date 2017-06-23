//
//  UIImageView+Extension.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func setImageFromWeb(link: String) {
        if let image = imageCache.object(forKey: link as AnyObject), let imageData = image as? Data {
            self.image = UIImage(data: imageData)
            return
        }
        
        YoutubeService.downloadImage(link: link) {[weak self] data in
            imageCache.setObject(data as AnyObject, forKey: link as AnyObject)
            guard let slf = self else { return }
            DispatchQueue.main.async {
                slf.image = UIImage(data: data)
            }
        }
    }
}
