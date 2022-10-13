//
//  HorizontalLiveViewCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 27.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class HorizontalLiveViewCell: BaseCell {
    
    
    override func setupViews() {
        super.setupViews()
        
        
        addSubview(nameLabel)
        let screenH = UIScreen.main.bounds.height
        var bottomConstant: CGFloat = -2
        if screenH > 700 {
            bottomConstant = -2
        } else {
            bottomConstant = 0
        }
        
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant).isActive = true
        
        addSubview(videoTempView)
        videoTempView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        videoTempView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        videoTempView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        videoTempView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (50 / 83)).isActive = true
        
        videoTempView.addSubview(videoView)

        
    }
    
    override func prepareForReuse() {
        refreshVideoView()
        
    }
    
    func refreshVideoView() {
        
        
//        videoView.setupPlayerViewCV(video: currentWorkoutArray[globalCurrentScreenIndexLive].videoLink)
        videoView.removeFromSuperview()
        
        videoView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (53 / 80)))
        videoTempView.addSubview(videoView)
    }
  
//    var videoView: VideoPlayerView {
//
//        let video = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (53 / 80)))
//
//
//        return video
//    }
    
    var videoView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (53 / 80)))
    
    
    let nameLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Exercise Name"
        if screenH > 850 {
            label.font = UIFont.systemFont(ofSize: 40)

        } else if screenH > 700 {
            label.font = UIFont.systemFont(ofSize: 33)
        } else if screenH > 600 {
        label.font = UIFont.systemFont(ofSize: 30)
        } else {
            label.font = UIFont.systemFont(ofSize: 28)
        }
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoTempView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        
      return view
    }()
    
    
    
    
    

    
    

}
