//
//  MenuBar.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var homeController: GenerateController?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! MenuCell
        
        
        cell.topLabel.text = menuBarTitles[indexPath.item]
        
//        cell.imageView.image = UIImage(named: menuBarImages[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
//        cell.tintColor = UIColor(red: 91, green: 13, blue: 14, alpha: 1)
        
        cell.backgroundColor = UIColor(red: 153/255, green: 244/255, blue: 255/255, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (frame.width)/3, height: frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let x = CGFloat(indexPath.item) * (frame.width / 3)
//        horizontalBarLeftConstraint?.constant = x
//
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
        
    }
    

    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.backgroundColor = UIColor(red: 153/255, green: 244/255, blue: 255/255, alpha: 1)
        
        
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        
        setupHorizontalBar()
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    let cellID = "cellID"
    
    let menuBarTitles: [String] = ["Morning", "Generate", "Night"]
   
    var horizontalBarLeftConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addSubview(horizontalBarView)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalBarLeftConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        
        horizontalBarLeftConstraint?.constant = (UIScreen.main.bounds.width / 3)

        
        
        horizontalBarLeftConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        
       

        
    }
    
    
    
    
    
    
    
    class MenuCell: BaseCell {
        
//        let imageView: UIImageView = {
        
            
//            let iv = UIImageView()
//            iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
//            iv.tintColor = UIColor(red: 91/250, green: 13/250, blue: 14/250, alpha: 1)
//            iv.backgroundColor = UIColor.green
//            return iv
   
//        }()
        
        let topLabel: UILabel = {
            
            let label = UILabel()
            if UIScreen.main.bounds.height > 850 {
                label.font = UIFont.systemFont(ofSize: 26)
            } else {
                label.font = UIFont.systemFont(ofSize: 23)
            }
            label.textColor = UIColor.white
            
            return label
            
        }()
        
       
        
//        IMPORTANT
//        override var isSelected: Bool {
//            didSet {
//                imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 91/250, green: 13/250, blue: 14/250, alpha: 1)
//            }
//        }
        
        
        override func setupViews(){
            super.setupViews()
            
            addSubview(topLabel)
            addConstraintsWithFormat(format: "H:[v0]", views: topLabel)
            addConstraintsWithFormat(format: "V:[v0]", views: topLabel)
            
            addConstraint(NSLayoutConstraint(item: topLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: topLabel, attribute: .centerY, relatedBy: .equal, toItem: self
                , attribute: .centerY, multiplier: 1, constant: 0))
       
            
        
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
