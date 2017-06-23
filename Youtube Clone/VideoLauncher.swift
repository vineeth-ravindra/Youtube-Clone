//
//  VideoLauncher.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class VideoLauncher: NSObject {
    
    let view: UIView  = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    func showView() {
        
        guard let window = UIApplication.shared.keyWindow else { print("Unable to open video window"); return}
        let width =  window.frame.width
        let height  =  window.frame.height
        let videoPlayer = VideoPlayer(frame: CGRect(x: 0, y: 0, width: width, height: width * 9 / 16))
        view.addSubview(videoPlayer)
        window.addSubview(view)
        view.frame = CGRect(x: width, y: height, width: width + 10, height: height + 10)
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {[weak self] in
                        guard let slf = self else {return}
                        slf.view.frame = window.frame
            }, completion: { _ in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
        })
    }
}
