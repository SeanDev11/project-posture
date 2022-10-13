//
//  ProgressSwipeable.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 20.11.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit


class ProgressSwipeable: SwipeCellVertical {
    
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
    
    
    let deleteImageView: UIImageView = {
        let image = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        
        return imageView
    }()
    
    let cancelDelete: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cancel"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviewsHere()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviewsHere() {
        
        visibleContainerView.addSubview(dateLabel)
        visibleContainerView.addSubview(seperatorView)
        visibleContainerView.addSubview(pictureImageView)
        visibleContainerView.addSubview(workoutsLabel)
        
        seperatorView.widthAnchor.constraint(equalTo: visibleContainerView.widthAnchor, multiplier: 1).isActive = true
        seperatorView.leftAnchor.constraint(equalTo: visibleContainerView.leftAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        pictureImageView.centerYAnchor.constraint(equalTo: visibleContainerView.centerYAnchor, constant: 10).isActive = true
        
        pictureImageView.centerXAnchor.constraint(equalTo: visibleContainerView.centerXAnchor).isActive = true
        
        pictureImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 65).isActive = true
        
        pictureImageView.heightAnchor.constraint(equalToConstant: (4 / 3) * (UIScreen.main.bounds.width - 65)).isActive = true
        
        dateLabel.bottomAnchor.constraint(equalTo: pictureImageView.topAnchor, constant: -7).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: pictureImageView.leftAnchor).isActive = true
        
        workoutsLabel.rightAnchor.constraint(equalTo: pictureImageView.rightAnchor).isActive = true
        
        workoutsLabel.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        
        
        let screenH = (UIScreen.main.bounds.width - 15) * (4/3)
        let screenW = UIScreen.main.bounds.width
        hiddenContainerView.backgroundColor = UIColor.clear
        
        deleteView.widthAnchor.constraint(equalToConstant: screenW * 0.3).isActive = true
        deleteView.heightAnchor.constraint(equalToConstant: screenH * 0.75).isActive = true
        deleteView.rightAnchor.constraint(equalTo: hiddenContainerView.rightAnchor).isActive = true
        deleteView.topAnchor.constraint(equalTo: hiddenContainerView.topAnchor).isActive = true
        deleteView.backgroundColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.0 / 255.0, alpha: 1)
        
        hiddenContainerView.addSubview(deleteImageView)
        deleteImageView.translatesAutoresizingMaskIntoConstraints = false
        deleteImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        deleteImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        deleteImageView.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor).isActive = true
        deleteImageView.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor).isActive = true
        
        
        
        
        
        cancelView.rightAnchor.constraint(equalTo: hiddenContainerView.rightAnchor).isActive = true
        cancelView.bottomAnchor.constraint(equalTo: hiddenContainerView.bottomAnchor).isActive = true
        
        cancelView.heightAnchor.constraint(equalToConstant: screenH * 0.25).isActive = true
        cancelView.widthAnchor.constraint(equalToConstant: screenW * 0.3).isActive = true
        
        
        
        cancelView.addSubview(cancelDelete)
        
        cancelDelete.pinEdgesToSuperView()
    }
    
    
}
