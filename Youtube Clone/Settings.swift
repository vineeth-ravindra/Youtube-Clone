//
//  Settings.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class Settings {
    var name: String?
    var image: UIImage?
    
    init(name: String, image: String) {
        self.name = name
        self.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
    }
    
    class func getSettingsData() -> [Settings] {
        return [
            Settings(name: "Terms and Conditions", image: "lock"),
            Settings(name: "Send Feedback", image: "feedback"),
            Settings(name: "Help", image: "question"),
            Settings(name: "Switch Account", image: "contact"),
            Settings(name: "Cancel", image: "cancel")
        ]
    }
    
}


