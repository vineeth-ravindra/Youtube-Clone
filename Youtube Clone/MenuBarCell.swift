//
//  MenuBarCell.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/20/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class MenuBarCell: CollectionViewCellBase {
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    override func setUpView() {
        super.setUpView()
        backgroundColor = .red
        addSubview(imageView)        
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 20),
        NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 20),
        NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    }
    
    public func setImageViewWithImage(image: String) {
        imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        
    }
    
}
