//
//  progressPicturesCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 19.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
import Foundation
import UIKit

class progressPicturesCell: BaseCell {
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pictureImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.lightGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "27.08.19"
        
        if UIScreen.main.bounds.width > 330 {
            label.font = UIFont.systemFont(ofSize: 22 )
        } else {
            label.font = UIFont.systemFont(ofSize: 19)
        }
        return label
    }()
    
    let workoutsLabel: UILabel = {
        let label = UILabel()
        label.text = "7 workouts"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if UIScreen.main.bounds.width > 330 {
            label.font = UIFont.systemFont(ofSize: 22 )
        } else {
            label.font = UIFont.systemFont(ofSize: 19)
        }
        return label
    }()
    
    let cellHeight: CGFloat = {
        let height = UIScreen.main.bounds.height * (2 / 3)
        return height
    }()
    

    override func setupViews() {
        addSubview(dateLabel)
        addSubview(seperatorView)
        addSubview(pictureImageView)
        addSubview(workoutsLabel)
        
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        addConstraintsWithFormat(format: "V:[v0(4)]|", views: seperatorView)
        
        pictureImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        
        pictureImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        pictureImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 65).isActive = true
        
        pictureImageView.heightAnchor.constraint(equalToConstant: (4 / 3) * (UIScreen.main.bounds.width - 65)).isActive = true
        
        dateLabel.bottomAnchor.constraint(equalTo: pictureImageView.topAnchor, constant: -7).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: pictureImageView.leftAnchor).isActive = true
        
        workoutsLabel.rightAnchor.constraint(equalTo: pictureImageView.rightAnchor).isActive = true
        
        workoutsLabel.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    }
    
    
}
