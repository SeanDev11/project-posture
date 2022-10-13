//
//  favoritesSubCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation



import UIKit

class favoritesSubCell: BaseCell {
    
    
    
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
    
    
    
    override func setupViews() {
        
        addSubview(favoriteNameLabel)
        addSubview(seperatorView)
        
        addSubview(durationLabel)
        
        
        
        favoriteNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        favoriteNameLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: ((cellHeight / 3) - 4)).isActive = true
        
        durationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        durationLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: (2*(cellHeight / 3)) + 4).isActive = true
        
        
       
        
//        addConstraintsWithFormat(format: "V:[v0(4)]|", views: seperatorView)
        seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        
        addSubview(beginButton)
        
        beginButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        beginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -((cellHeight - 4 ) / 3)).isActive = true
        
        
    }
    
    
    
}
