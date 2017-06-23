//
//  MenuBar.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/20/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

class MenuBar: UIView {
    
    
    weak var homeController: MainViewController?
    
    let cellId = "cellIdentifer"
    
    lazy var collectionView: UICollectionView = {[weak self] in
        guard let slf = self else {return UICollectionView()}
        let collView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collView.register(MenuBarCell.self, forCellWithReuseIdentifier: slf.cellId)
        collView.dataSource = slf
        collView.delegate = slf
        collView.backgroundColor = .red
        return collView
        }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var underlineLeftConstraint: NSLayoutConstraint?
    
    fileprivate let imageDict: [String] = ["home", "fire", "folder", "contact"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        backgroundColor = .red
        addSubview(collectionView)
        addConstraint(withFormat: "V:|[v0]|", forViews: collectionView)
        addConstraint(withFormat: "H:|[v0]|", forViews: collectionView)
        setUpUnderLine()
    }
    
    
    func setUpUnderLine() {
        addSubview(underlineView)
        underlineLeftConstraint = underlineView.leftAnchor.constraint(equalTo: self.leftAnchor)
        underlineLeftConstraint?.isActive = true
        underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underlineView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal error occoured on creating menu bar")
    }
    
}

extension MenuBar: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
        cell.setImageViewWithImage(image: imageDict[indexPath.item])
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.left)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(frame.width / CGFloat(imageDict.count)), height: CGFloat(frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.setScrollPostion(index: indexPath.item)
    }
}
