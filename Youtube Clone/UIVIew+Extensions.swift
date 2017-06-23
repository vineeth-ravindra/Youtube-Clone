//
//  UIVIew+Extensions.swift
//  Youtube Clone
//
//  Created by Vineeth Ravindra on 6/18/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func createViewDict(views: [UIView]) -> [String: UIView] {
        var retDict = [String: UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            retDict[key] = view
        }
        return retDict
    }
    
    func addConstraint(withFormat format: String, forViews views: UIView...) {
        guard views.count > 0 else { return }
        let viewDict = createViewDict(views: views)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil, views: viewDict))
    }

}
