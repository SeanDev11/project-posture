//
//  NoContentCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 10.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class NoContentCell: BaseCell {
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(mainLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: mainLabel)
        mainLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        
    }
    
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Favorites"
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        if UIScreen.main.bounds.width > 330 {
            
            label.font = UIFont.systemFont(ofSize: 35)
        } else {
            
            label.font = UIFont.systemFont(ofSize: 32)
            
        }
        
        return label
    }()
    
    
    
}
