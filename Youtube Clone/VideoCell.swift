//
//  VideoCell.swift
//  Youtube Clone
//
//  Created by Vineeth Ravindra on 6/18/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class VideoCell: CollectionViewCellBase {
    let thumbnailImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let profileView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    override func setUpView() {
        backgroundColor = .white
        addSubview(thumbnailImage)
        addSubview(profileView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addConstraint(withFormat: "V:|-8-[v0]-5-[v1(60)]|", forViews: thumbnailImage , profileView)
        addConstraint(withFormat: "H:|-8-[v0]-8-|", forViews: thumbnailImage)
        addConstraint(withFormat: "H:|-16-[v0(60)]", forViews: profileView)
        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileView, attribute: .right, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImage, attribute: .right, multiplier: 1, constant: 1),
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImage, attribute: .bottom, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 20)
            ])
        
        addConstraints([
            NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: profileView, attribute: .right, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 1),
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
            ])
    }
}
