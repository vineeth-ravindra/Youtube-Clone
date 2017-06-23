//
//  SettingsMenu.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/21/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation
import UIKit

enum SettingsEnum: String {
    case cancel, contact, question, feedback, lock
    static func getEnumFromString(string: String) -> SettingsEnum {
        switch string {
        case "Terms and Conditions" :
            return .lock
        case "Send Feedback" :
            return .feedback
        case "Help" :
            return .question
        case "Switch Account" :
            return .contact
        case "Cancel" :
            return .cancel
        default:
            return .lock
        }
    }
    
}

protocol SettingsMenuProtocol: class {
    func itemSelected(item: SettingsEnum)
}

class SettingsMenu: NSObject {
    
    fileprivate let cellId = "cellId"
    fileprivate let settingsList: [Settings] = Settings.getSettingsData()
    public var delegate: SettingsMenuProtocol?
    
    fileprivate let screenWidth: CGFloat = {
        guard let window = UIApplication.shared.keyWindow else {return 400}
        return window.frame.width
    }()
    
    fileprivate let screenHeight: CGFloat = {
        guard let window = UIApplication.shared.keyWindow else {return 400}
        return window.frame.height
    }()
    
    fileprivate let cellHeight: CGFloat = 50
    
    fileprivate lazy var collectionViewHeight: CGFloat = {[weak self] in
        guard let slf = self else {return 0}
        return slf.cellHeight * CGFloat(slf.settingsList.count)
        }()
    
    
    lazy var collectionView: UICollectionView = { [weak self] in
        guard let slf = self else {return UICollectionView()}
        let collView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collView.delegate = slf
        collView.dataSource = slf
        collView.register(SettingsCell.self, forCellWithReuseIdentifier: slf.cellId)
        collView.backgroundColor = .white
        return collView
        }()
    
    
    lazy var backgroundView: UIView = {[weak self] in
        guard let slf = self else {return UIView()}
        let view = UIView()
        let tapGesture = UITapGestureRecognizer(target: slf, action: #selector(SettingsMenu.dismissClicked(_ : )))
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.addGestureRecognizer(tapGesture)
        return view
        }()
    
    
    func dismissClicked(_ notification: UITapGestureRecognizer) {
        hideMenu(completion: nil)
    }
    
    func hideMenu(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {[weak self] in
            guard let slf = self else { return }
            slf.backgroundView.alpha = 0
            slf.collectionView.frame = CGRect(x: 0, y: slf.screenHeight, width: slf.screenWidth, height: slf.collectionViewHeight)
            }, completion: completion)
    }
    
    func setUpView() {
        guard let window = UIApplication.shared.keyWindow else {
            print("Unable to find applcation window")
            return
        }
        
        backgroundView.frame = window.frame
        backgroundView.alpha = 0
        
        
        collectionView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: collectionViewHeight)
        
        window.addSubview(backgroundView)
        window.addSubview(collectionView)
    }
    
    func showMenu() {
        setUpView()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {[weak self] in
            guard let slf = self else { return }
            slf.backgroundView.alpha = 1
            let x = slf.screenHeight - slf.collectionViewHeight
            slf.collectionView.frame = CGRect(x: 0, y: x, width: slf.screenWidth, height: slf.collectionViewHeight)
            }, completion: nil)
        
    }
    
}

extension SettingsMenu: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        cell.setUpViewWithSetting(setting: settingsList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hideMenu(completion: {[weak self] _ in
            guard let slf = self else {return}
            let item = slf.settingsList[indexPath.item]
            if let del = slf.delegate {
                del.itemSelected(item: SettingsEnum.getEnumFromString(string: item.name!))
            }
        })
        
    }
}
