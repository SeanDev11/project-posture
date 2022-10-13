//
//  TrackController.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var doNotAnimateAndScroll = false
var trackControllerFirstLaunch = true
let layoutForLoading = UICollectionViewFlowLayout()
var onlyForLoading: TrackController = TrackController(collectionViewLayout: layoutForLoading)

class TrackController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        settingsPopUp.modalPresentationStyle = .overCurrentContext
        
        onlyForLoading = self
        
        
        imagePickerSetup()
        coreDataSetup()
        
        
        setupCollectionView()
        
        setupMenuBarTrack()
       
        setupNavBar()

        fillDataArray()
        
        
}
    
    var littleDelayTimer = Timer()
    
    
    override func viewWillAppear(_ animated: Bool) {
        if trackControllerFirstLaunch == false && doNotAnimateAndScroll == false {
        
        let indexPath = NSIndexPath(item: 0, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: false)
        currentScreenIndex = 0
        
        littleDelayTimer = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(barGraphRefresh), userInfo: nil, repeats: false)
        }
        
    }
    
   
    
    @objc func barGraphRefresh() {
        
        let indexPathThere = IndexPath(item: 0, section: 0)
        if let trackCell = collectionView.cellForItem(at: indexPathThere) {
            let barCell = trackCell as! TrackBarCell
            barCell.delayAnimation()
            barCell.animateAllCircles()
            let totalTime = defaults.integer(forKey: "TotalTime")
            barCell.totalMinutesNumber.text = "\(totalTime)"
            barCell.totalWorkoutsNumber.text = "\(defaults.integer(forKey: "TotalWorkouts"))"
            let averageMinutes: Double = Double(totalTime) /  Double(MacawBarGraph.lastFiveShows.count)
            barCell.averageMinutesNumber.text = "\(Int(averageMinutes))"
            
            
            
        }
        
        littleDelayTimer.invalidate()
    }
    
    func reloadEverything() {
        let indexPathHere = IndexPath(item: 1, section: 0)
        if let progressCell = collectionView.cellForItem(at: indexPathHere) {
            let pC = progressCell as! trackMainCell
            pC.reloadImages()
        }
        
    }
    
    
    
    
    var allImagesArray: [FullRes] = []
    
    func fillDataArray() {
        
        
        allImagesArray = []
        
        
        loadImages { (images) -> Void in
         
            if let allImages = images {
                for x in allImages {
                    self.allImagesArray.append(x)
                }
            }
            
        }
        
    }
    
  
    
    
    
    

    private func setupCollectionView() {
        
 
        collectionView.register(trackMainCell.self, forCellWithReuseIdentifier: "trackMainCell")
        collectionView.register(TrackBarCell.self, forCellWithReuseIdentifier: "BarCell")
        
        //        WORK on this ADAPTABLE based on generateBUtton
        if UIScreen.main.bounds.height > 800 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
            
        } else if UIScreen.main.bounds.height > 600 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
            
        } else {
            
            collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
            
            
        }
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView?.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    

    private func setupNavBar() {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: view.frame.height))
        titleLabel.text = "P|P"
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        titleLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "SettingsIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleThis))
    
       
        
        
        navigationItem.rightBarButtonItem = moreButton
        
        
    }
    
    @objc func handleThis() {
        
        if globalSettingsIsLaunched == false {
            self.present(settingsPopUp, animated: true)
            globalSettingsIsLaunched = true
        }
        
    }
    
    
    
    
//    SAVING LOADING CODE
    
    let imagePicker = UIImagePickerController()
    let convertQueue = DispatchQueue(label: "convertQueue", attributes: .concurrent)
    let saveQueue = DispatchQueue(label: "saveQueue", attributes: .concurrent)
    var managedContext: NSManagedObjectContext?
    
    
    @objc func capture() {
        
        
            doNotAnimateAndScroll = true
        
         present(imagePicker, animated: true)
    
    }
    
    
    
   
    
    lazy var menuBarTrack: MenuBarTrack = {
        
        let mb = MenuBarTrack()
        mb.backgroundColor = UIColor.lightGray
        mb.homeController = self
        return mb
        
    }()
    
    private func setupMenuBarTrack() {
        view.addSubview(menuBarTrack)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBarTrack)
        view.addConstraintsWithFormat(format: "V:|[v0(40)]", views: menuBarTrack)
        
    }
    
    
    
    
    
    
    
    
    
    
    var currentScreenIndex = 0
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        
        currentScreenIndex = menuIndex
 
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBarTrack.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 2
    
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuBarTrack.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        currentScreenIndex = Int(index)
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBarTrack.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
       
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var ID: String = "BarCell"
        
        if indexPath.item == 1 {
            ID = "trackMainCell"
        } else {
            ID = "BarCell"
        }

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath)
        
        return cell
        
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIScreen.main.bounds.height > 800  {
            
            //            was 80
            return CGSize(width: view.frame.width, height: view.frame.height - 40 - 80)
            
        } else if UIScreen.main.bounds.height > 700 {
            
            return CGSize(width: view.frame.width, height: view.frame.height - 30 - 60 )
            
        } else if UIScreen.main.bounds.width > 400 {
            
            return CGSize(width: view.frame.width, height: view.frame.height - 40 - 60 )
            
        } else {
            //            was 40
            return CGSize(width: view.frame.width, height: view.frame.height - 40 - 50 )
            
        }
        
        
    }
    
    
    
    
    


}
