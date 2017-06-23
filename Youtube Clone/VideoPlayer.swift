//
//  VideoPlayer.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayer: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        backgroundColor = .black
        let url = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"

        if let url = URL(string: url) {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.frame
            self.layer.addSublayer(playerLayer)
            player.play()
        }
    }

}
