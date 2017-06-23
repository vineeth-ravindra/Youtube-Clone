//
//  UICollectionViewCell+Base.swift
//  Youtube Clone
//
//  Created by Vineeth Ravindra on 6/18/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCellBase: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("A fatal error just occoured")
    }
    
    func setUpView() {
        
    }

}
