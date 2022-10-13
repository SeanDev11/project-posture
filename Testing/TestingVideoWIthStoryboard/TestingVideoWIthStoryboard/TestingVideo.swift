//
//  ViewController.swift
//  TestingVideoWIthStoryboard
//
//  Created by Sean Devine on 06.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit
import AVFoundation

class TestingVideo: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    
   lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: self.player)
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (9 / 16))
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
       return layer
    }()
    
    var player: AVQueuePlayer = {
        let play = AVQueuePlayer()
        play.isMuted = true
        return play
    }()

    var playerLooper: AVPlayerLooper?
    
    var playerItem: AVPlayerItem?

    
    lazy var playerLayerTwo: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: self.playerTwo)
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (9 / 16))
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return layer
    }()
    
    var playerTwo: AVQueuePlayer = {
        let play = AVQueuePlayer()
        play.isMuted = true
        return play
    }()
    
    var playerLooperTwo: AVPlayerLooper?
    
    var playerItemTwo: AVPlayerItem?
    
    
    lazy var playerLayerThree: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: self.playerThree)
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (9 / 16))
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return layer
    }()
    
    var playerThree: AVQueuePlayer = {
        let play = AVQueuePlayer()
        play.isMuted = true
        return play
    }()
    
    var playerLooperThree: AVPlayerLooper?
    
    var playerItemThree: AVPlayerItem?
    
    
    
//    var cellCell: UICollectionViewCell?

    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("DID SCROLL")
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("DID END DRAGGING")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playVideo), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseVideo), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    
    @objc func playVideo() {
        playerThree.play()
        playerTwo.play()
        player.play()
    }
    
    @objc func pauseVideo() {
        playerThree.pause()
        playerTwo.pause()
        player.pause()
    }
    func setupCollectionView() {
        
        collectionView.register(VideoCellCell.self, forCellWithReuseIdentifier: "VideoCellCell")
        collectionView.backgroundColor = UIColor.blue
        
        collectionView.isPagingEnabled = true
       
    }
    
    
    
    var amount = 0
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
 
       let cellCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCellCell", for: indexPath)
        
        if (indexPath.section + 1) % 3 == 0 {
            cellCell.layer.addSublayer(playerLayerThree)
            
            if let videoURLThree = Bundle.main.path(forResource: "theVideo", ofType: "MOV") {
                playerItemThree = AVPlayerItem(url: URL(fileURLWithPath: videoURLThree))
                playerLooperThree = AVPlayerLooper(player: playerThree, templateItem: playerItemThree!)
                
                playerThree.play()
            }
            
        } else if (indexPath.section + 1) % 2 == 0 {
        cellCell.layer.addSublayer(playerLayerTwo)
            
            if let videoURLTwo = Bundle.main.path(forResource: "theVideo", ofType: "MOV") {
                playerItemTwo = AVPlayerItem(url: URL(fileURLWithPath: videoURLTwo))
                playerLooperTwo = AVPlayerLooper(player: playerTwo, templateItem: playerItemTwo!)
                
                playerTwo.play()
            }
            
            
        } else {
            cellCell.layer.addSublayer(playerLayer)
            if let videoURL = Bundle.main.path(forResource: "theVideo", ofType: "MOV") {
                playerItem = AVPlayerItem(url: URL(fileURLWithPath: videoURL))
                playerLooper = AVPlayerLooper(player: player, templateItem: playerItem!)
                
                player.play()
            }
        }
        
        
        return cellCell
        
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (9/16))
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

