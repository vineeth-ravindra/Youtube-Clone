//
//  SettingsCell.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class SettingsCell: CollectionViewCellBase {
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .darkGray : .lightGray
            backgroundColor = isSelected ? .lightGray : .white
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .darkGray : .lightGray
            backgroundColor = isHighlighted ? .lightGray : .white
        }
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    override func setUpView() {
        super.setUpView()
        addSubview(imageView)
        addSubview(label)
        addConstraint(withFormat: "H:|-8-[v0(30)]-5-[v1]|", forViews: imageView,label)
        addConstraint(withFormat: "V:[v0(30)]", forViews: imageView)
        addConstraint(withFormat: "V:|[v0]|", forViews: label)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func setUpViewWithSetting(setting: Settings) {
        imageView.image = setting.image
        imageView.tintColor = .lightGray
        label.text = setting.name
    }
}
