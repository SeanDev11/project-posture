//
//  generateCellCV.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 07.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class generateCellCV: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    

    
    
    let filler = Filler()
    
    let homeController = GenerateController()
    
    let selectorCellHeight: CGFloat = {
        
        let screenHeight = UIScreen.main.bounds.height
        var height: CGFloat = 350
        if screenHeight > 850 {
            height = screenHeight / 7.5
        } else if screenHeight > 800 {
            height = 667 / 6.6368
        } else {
            height = screenHeight / 6.6368
        }
        
        return height
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        
        
        collectionView.register(selectorCell.self, forCellWithReuseIdentifier: "selectorID")
        collectionView.register(dailyGoalViewCell.self, forCellWithReuseIdentifier: "dailyGoalID")
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyGoalID", for: indexPath) as! dailyGoalViewCell
            cell.minutesLabel.text = "\(defaults.integer(forKey: "DailyProgress"))"
            cell.backgroundColor = UIColor.clear
            return cell
            
        } else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectorID", for: indexPath) as! selectorCell
        cell.mainTitleLabel.text = filler.topLabelGenerate[indexPath.item]
        cell.subTitleLabel.text = filler.bottomLabelGenerate[indexPath.item]
        cell.plusButton.tag = indexPath.item
        
        return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 3 {
            if UIScreen.main.bounds.height > 850 {
                 return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (200 + 3*(selectorCellHeight) + homeController.navBarHeight + 20))
                
            } else if UIScreen.main.bounds.height > 800 {
                
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (200 + 3*(selectorCellHeight) + homeController.navBarHeight + 20))
                
            } else if UIScreen.main.bounds.height > 700 {
                
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (110 + 3*(selectorCellHeight) + homeController.navBarHeight + 60))
                
            } else {
            
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (110 + 3*(selectorCellHeight) + homeController.navBarHeight + 40))
            }
        } else {
        
        return CGSize(width: UIScreen.main.bounds.width, height: selectorCellHeight)
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    
    
    
    
    
}
