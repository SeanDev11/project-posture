//
//  workoutExercisesCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 06.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class workoutExercisesCell: BaseCell {
    
    
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        //        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Exercise Name"
        if UIScreen.main.bounds.height > 850 {
            label.font = UIFont.systemFont(ofSize: 29)
        } else if UIScreen.main.bounds.width > 330 {
            label.font = UIFont.systemFont(ofSize: 26 )
        } else {
            label.font = UIFont.systemFont(ofSize: 23)
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "30 seconds"
        if UIScreen.main.bounds.height > 850 {
            label.font = UIFont.systemFont(ofSize: 24)
        } else if UIScreen.main.bounds.width > 330 {
            label.font = UIFont.systemFont(ofSize: 22 )
        } else {
            label.font = UIFont.systemFont(ofSize: 19)
        }
        
        return label
    }()
    
    let videoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.lightGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var theXConstantFix: CGFloat = -6
    
    override func setupViews() {
        
        addSubview(exerciseNameLabel)
        addSubview(seperatorView)
        addSubview(durationLabel)
        addSubview(videoImageView)
        
        addConstraintsWithFormat(format: "H:|-15-[v0]", views: exerciseNameLabel)
       

        
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        addConstraintsWithFormat(format: "V:[v0(4)]|", views: seperatorView)
        

        var videoImageHeight: CGFloat
        
        if UIScreen.main.bounds.height > 880 {
        
            videoImageHeight = (UIScreen.main.bounds.height / 7.1) - 25
            
    } else if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
            videoImageHeight = (UIScreen.main.bounds.height / 7) - 25
        } else {      
            videoImageHeight = (UIScreen.main.bounds.height / 6.2) - 25
        }
        
        let videoImageWidth = videoImageHeight * (80 / 53)
        
        addConstraintsWithFormat(format: "H:[v0(\(videoImageWidth))]-15-|", views: videoImageView)
        
        videoImageView.heightAnchor.constraint(equalToConstant: videoImageHeight).isActive = true
        
        
        
        exerciseNameLabel.topAnchor.constraint(equalTo: videoImageView.topAnchor, constant: 2).isActive = true
        
        durationLabel.leftAnchor.constraint(equalTo: exerciseNameLabel.leftAnchor).isActive = true
        
        durationLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor,constant: 8).isActive = true
        
    }
    
    func makeConstraintFix() {
        
        videoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: theXConstantFix).isActive = true
        
    }
    
    
}
