//
//  FeedCell.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import UIKit

class FeedCell: CollectionViewCellBase {
    
    let cellIdentifier = "cellIdentifier"
    
    lazy var collectionView: UICollectionView = {[weak self] in
        guard let slf = self else { return UICollectionView() }
        let layout = UICollectionViewFlowLayout()
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.register(VideoCell.self, forCellWithReuseIdentifier: slf.cellIdentifier)
        collView.delegate = slf
        collView.dataSource = slf
        return collView
        }()
    
    var youtubeChanelDict: [YoutubeModel]?
    
    override func setUpView() {
        super.setUpView()
        loadData()
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        addConstraint(withFormat: "V:|[v0]|", forViews: collectionView)
        addConstraint(withFormat: "H:|[v0]|", forViews: collectionView)
    }
    
    func loadData() {
        YoutubeService.getInfoDict {[weak self] in
            guard let slf = self else { return }
            slf.youtubeChanelDict = $0
            DispatchQueue.main.async {
                slf.collectionView.reloadData()
            }
        }
    }
    
    func setCellWithImages(model: YoutubeModel, cell: VideoCell) {
        cell.profileView.setImageFromWeb(link: model.profileImage!)
        cell.thumbnailImage.setImageFromWeb(link: model.thumbnailImage!)
        cell.titleLabel.text = model.title
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = NumberFormatter.Style.decimal
        
        if let numViews = model.numberOfViews, let chName = model.channelName, let duration = model.duration {
            let floatNumViews = Float(numViews)!
            cell.descriptionLabel.text = chName + " • " + numberFormater.string(from: NSNumber(value: floatNumViews))! + " views • " + duration + " minutes"
        }
    }
}

extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collection = youtubeChanelDict else { return 0 }
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier , for: indexPath) as! VideoCell
        
        if let model = youtubeChanelDict?[indexPath.row] {
            setCellWithImages(model : model, cell: cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize(width: frame.width, height: height  + 16 + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        VideoLauncher().showView()
    }
    
}
