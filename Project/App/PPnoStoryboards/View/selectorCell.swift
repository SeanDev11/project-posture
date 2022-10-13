
//  selectorCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    
    
    func setupViews(){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class selectorCell: BaseCell {
    
    
    
    let selectorCellHeight: CGFloat = {
        
        let screenHeight = UIScreen.main.bounds.height
        var height: CGFloat = 350
        if screenHeight > 800 {
            height = 667 / 6.6368
        } else {
            height = screenHeight / 6.6368
        }
        
        return height
    }()
    
    
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    
    let mainAndSubConstant: CGFloat = {
        
        var constant: CGFloat = 0
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight > 800 {
            constant = (607 / 6) / 7
        }
        else if screenHeight > 600 {
            constant = ((screenHeight - 60) / 6) / 7
        } else {
            constant = ((screenHeight - 60) / 6) / 11
        }
        
        return constant
        
    }()
    
    
    lazy var plusButtonHeightConstant: CGFloat = -(selectorCellHeight.self  / 2)
    
    
    let mainTitleLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Testing Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 1
        var fontS: CGFloat = 30
        if screenH > 850 {
            fontS = 31
        } else if screenH > 800 {
            fontS = 30
        } else if screenH > 700 {
            fontS = 30
        } else {
            fontS = 27
        }
        label.font = UIFont(name: "Avenir-Medium", size: fontS)
        
//        if UIScreen.main.bounds.width > 330 {
//
//            label.font = UIFont(name: "Avenir-Medium", size: 31)
//        } else {
//
//         label.font = UIFont.systemFont(ofSize: 30)
//         label.font = UIFont(name: "Avenir-Medium", size: 27)
//        }
        return label
    }()
    
    
    let subTitleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "bottom"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if UIScreen.main.bounds.width > 330 {
            label.font = UIFont.systemFont(ofSize: 24 )
        } else {
            label.font = UIFont.systemFont(ofSize: 23)
        }
        return label
    }()
    
  
    
    
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        //        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        button.setTitle("+", for: .normal)
        
        button.setTitleColor(UIColor.black, for: .normal)
        
        if screenHeight > 800 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        }
        if screenWidth > 400 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        }
        
        
        button.addTarget(self, action: #selector(GenerateController.plusButtonPressed), for: .touchUpInside)
        
        return button
        
    }()
    
    
    
    
    
    
    
    override func setupViews() {
        
        addSubview(mainTitleLabel)
        addSubview(seperatorView)
//        addSubview(subTitleLabel)
        addSubview(plusButton)
        
        

        addConstraintsWithFormat(format: "H:[v0(40)]-15-|", views: plusButton)
        
      
        
        plusButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: mainTitleLabel)
        
        mainTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        addConstraintsWithFormat(format: "V:[v0(4)]|", views: seperatorView)
        
//        addConstraintsWithFormat(format: "H:|-10-[v0]", views: subTitleLabel)
        
        
        
        
        
    }
    
    
    
    
}
