//
//  MainViewController.swift
//  Youtube Clone
//
//  Created by Vineeth Ravindra on 6/18/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import UIKit

var imageCache =  NSCache<AnyObject, AnyObject>()

class MainViewController: UICollectionViewController {
    let cellIdentifierFeedCell = "cellIdentifier"
    let cellIdentifierTrendingCell = "cellIdentifierTrending"
    let cellIdentifierSubscriptionCell = "cellIdentifierTrending123"
    
    fileprivate lazy var titleView: UILabel  = { [weak self] in
        guard let slf = self else { return UILabel() }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: slf.view.frame.width, height: slf.view.frame.height))
        label.textColor = .white
        label.text = "Home"
        return label
    }()
    
    fileprivate var youtubeChanelDict: [YoutubeModel]?
    
    fileprivate lazy var settingsmenu: SettingsMenu = { [weak self] in
        guard let slf = self else { return SettingsMenu() }
        let menu = SettingsMenu()
        menu.delegate = slf
        return menu
        }()
    
    lazy var menuBar: MenuBar = {[weak self] in
        guard let slf = self else { return MenuBar() }
        let menu = MenuBar(frame: .zero)
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.homeController = slf
        return menu
        }()
    
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()
    }
    
    
    
    func setUpView() {
        configureNavBar()
        configureCollectionView()
        setUpMenuBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureNavBar() {
        if let flowLayoutOption = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayoutOption.scrollDirection = .horizontal
            collectionView?.isPagingEnabled = true
        }

        navigationItem.titleView = titleView
        
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let menu = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let searchBar = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(MainViewController.searchClicked(_ :)))
        let settingsMenu = UIBarButtonItem(image: menu, style: .plain, target: self, action: #selector(MainViewController.menuClicked(_ :)))
        navigationItem.rightBarButtonItems = [settingsMenu, searchBar]
    }
    
    func searchClicked(_ sender: UIBarButtonItem) {
        
    }
    
    func menuClicked(_ sender: UIBarButtonItem) {
        settingsmenu.showMenu()
    }
    
    func configureCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellIdentifierFeedCell)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: cellIdentifierTrendingCell)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: cellIdentifierSubscriptionCell)
    }
    
    func setUpMenuBar() {
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        view.addConstraint(withFormat: "H:|[v0]|", forViews: redView)
        view.addConstraint(withFormat: "V:|[v0(50)]", forViews: redView)
        
        
        view.addSubview(menuBar)
        view.addConstraint(withFormat: "H:|[v0]|", forViews: menuBar)
        view.addConstraint(withFormat: "V:[v0(50)]", forViews: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func setTitle(index: Int) {
        
        switch index {
        case 0:
            titleView.text = "Home"
        case 1:
            titleView.text = "Subscription"
        case 2:
            titleView.text = "Trending"
        case 3:
            titleView.text = "Account"
        default: break
        }
    }
    
}

extension MainViewController:  UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierFeedCell, for: indexPath)
        switch indexPath.item {
        case 0:
            cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierFeedCell, for: indexPath)
        case 1:
            cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierTrendingCell, for: indexPath)
        case 2:
            cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierSubscriptionCell, for: indexPath)
        default:
            break
        }
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.underlineLeftConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offset = targetContentOffset.pointee.x / view.frame.width
        let iPath = IndexPath(item: Int(offset), section: 0)
        menuBar.collectionView.selectItem(at: iPath, animated: true, scrollPosition: [])
        setTitle(index: Int(offset))
    }
    
   
}

extension MainViewController: SettingsMenuProtocol {
    
    func itemSelected(item: SettingsEnum) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
        switch item {
        case .cancel:
            vc.navigationItem.title = "Cancel"
        case .contact:
            vc.navigationItem.title = "Contact"
        case .question:
            vc.navigationItem.title = "Question"
        case .feedback:
            vc.navigationItem.title = "Feedback"
        case .lock:
            vc.navigationItem.title = "Terms & Conditions"
        }
    }
    
    func setScrollPostion(index: Int) {
        setTitle(index: index)
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at:  indexPath, at: [], animated: true)
    }
}
