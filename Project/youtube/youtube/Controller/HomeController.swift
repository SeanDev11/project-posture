//
//  ViewController.swift
//  youtube
//
//  Created by Sean Devine on 04.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var videos: [Video] = {
//
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//
//    var blankSpaceVideo = Video()
//    blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//    blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numOfViews = 25888145
//
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numOfViews = 1350245
//
//    return [blankSpaceVideo, badBloodVideo]
//
//
//}()
    
    
    
    let cellId = "cellId"
    
    let trendingCellId = "trendingCellId"
    
    let subscriptionCellId = "subscriptionCellId"
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    let viewName = "Home"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
//        navigationItem.title = "Home"
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        testCapabilities()
        
    }
    
    let testButton: UIButton = {
        
        let button = UIButton()
//        button.setTitle("TestTest", for: .normal)
       button.titleLabel?.isEnabled = true
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    
    func testCapabilities() {
        
        
        view.addSubview(testButton)
        
        view.addConstraint(NSLayoutConstraint(item: testButton, attribute: .top, relatedBy: .equal, toItem: menuBar, attribute: .bottom, multiplier: 1, constant: 15))
        
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: testButton)
        
    }
    
    
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
//        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
  
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)

        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        
        collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true

    }
    
    func setupNavBarButtons() {
        
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
        
        
        
        
    }
    
    
    
    @objc func handleSearch() {
        
        
        print(123)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        
        setTitleForIndex(index: menuIndex)
        
    }
    
    private func setTitleForIndex(index: Int) {
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    
    }
    
    
    
    
    
    lazy var settingsLauncher: SettingsLauncher = {
        
        let launcher = SettingsLauncher()
        launcher.homeController = self
        
       return launcher
    }()
    
    
    @objc func handleMore() {
        
        settingsLauncher.showSettings()
        
        
        
    }
    
    func showControllerForSetting(setting: Setting) {
        
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
        
    }
    
  
    
    
    
    lazy var menuBar: MenuBar = {
        
        let mb = MenuBar()
        mb.homeController = self
        return mb
        
        
    }()
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: Int(index))
        
        if index == 0 {
            testButton.isHidden = false
        } else if index == 1 {
            testButton.isHidden = true
            
        } else if index == 2 {
            testButton.isHidden = true
            
        } else {
            testButton.isHidden = false
        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ID: String
        
        if indexPath.item == 1 {
            ID = trendingCellId
            
        } else if indexPath.item == 2 {
            ID = subscriptionCellId
            
        } else {
            ID = cellId
            
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath)
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
 
    
    
    
}








