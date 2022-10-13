//
//  FavoriteCellSwipe.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 19.11.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCellSwipe: SwipeableCollectionViewCell {
    
    
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8 minutes"
        
        if UIScreen.main.bounds.width > 330 {
            label.font = UIFont.systemFont(ofSize: 22 )
        } else {
            label.font = UIFont.systemFont(ofSize: 19)
        }
        
        return label
    }()
    
    
    
    let favoriteNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorite Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    
    
    let beginButton: UILabel = {
        let btn = UILabel()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.text = ">"
        btn.font = UIFont.systemFont(ofSize: 50, weight: .ultraLight)
        btn.textColor = UIColor.lightGray
        
        return btn
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
    
    let cellHeight: CGFloat = {
        let screenH = UIScreen.main.bounds.height
        var height = UIScreen.main.bounds.height / 6
        if screenH > 850 {
            height = UIScreen.main.bounds.height / 8
        } else if screenH > 800 {
            height = UIScreen.main.bounds.height / 7.4
        } else if screenH > 700 {
            height = UIScreen.main.bounds.height / 6.9
        } else {
            height = UIScreen.main.bounds.height / 6
        }
        
        
        return height
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviewsHere()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviewsHere() {
        
        visibleContainerView.addSubview(favoriteNameLabel)
        visibleContainerView.addSubview(seperatorView)
        visibleContainerView.addSubview(durationLabel)
        
        favoriteNameLabel.leftAnchor.constraint(equalTo: visibleContainerView.leftAnchor, constant: 25).isActive = true
        favoriteNameLabel.centerYAnchor.constraint(equalTo: visibleContainerView.topAnchor, constant: ((cellHeight / 3) - 4)).isActive = true
        
        durationLabel.leftAnchor.constraint(equalTo: visibleContainerView.leftAnchor, constant: 25).isActive = true
        durationLabel.centerYAnchor.constraint(equalTo: visibleContainerView.topAnchor, constant: (2*(cellHeight / 3)) + 4).isActive = true
        
        
        seperatorView.bottomAnchor.constraint(equalTo: visibleContainerView.bottomAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        seperatorView.leftAnchor.constraint(equalTo: visibleContainerView.leftAnchor).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: visibleContainerView.widthAnchor).isActive = true
        
        visibleContainerView.addSubview(beginButton)
        beginButton.centerYAnchor.constraint(equalTo: visibleContainerView.centerYAnchor, constant: -4).isActive = true
        beginButton.rightAnchor.constraint(equalTo: visibleContainerView.rightAnchor, constant: -((cellHeight - 4 ) / 3)).isActive = true
        
        hiddenContainerView.backgroundColor = UIColor.clear
        hiddenContainerView.addSubview(deleteImageView)
        deleteView.widthAnchor.constraint(equalTo: hiddenContainerView.widthAnchor, multiplier: 0.7).isActive = true
        deleteView.heightAnchor.constraint(equalTo: hiddenContainerView.heightAnchor, multiplier: 1).isActive = true
        deleteView.leftAnchor.constraint(equalTo: hiddenContainerView.leftAnchor).isActive = true
        deleteView.bottomAnchor.constraint(equalTo: hiddenContainerView.bottomAnchor).isActive = true
        deleteView.backgroundColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.0 / 255.0, alpha: 1)
        deleteImageView.translatesAutoresizingMaskIntoConstraints = false
        deleteImageView.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor).isActive = true
        deleteImageView.centerYAnchor.constraint(equalTo: hiddenContainerView.centerYAnchor).isActive = true
        deleteImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        deleteImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        cancelView.rightAnchor.constraint(equalTo: hiddenContainerView.rightAnchor).isActive = true
        cancelView.centerYAnchor.constraint(equalTo: hiddenContainerView.centerYAnchor).isActive = true
        
        cancelView.heightAnchor.constraint(equalTo: hiddenContainerView.heightAnchor).isActive = true
        cancelView.widthAnchor.constraint(equalTo: hiddenContainerView.widthAnchor, multiplier: 0.3).isActive = true
        
        
        cancelView.addSubview(cancelDelete)
        
        cancelDelete.pinEdgesToSuperView()
        
        
    }
    
    
    
}
