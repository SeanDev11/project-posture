//
//  MenuBar.swift
//  youtube
//
//  Created by Sean Devine on 07.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named: menuBarImages[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        cell.tintColor = UIColor(red: 91, green: 13, blue: 14, alpha: 1)
        
       cell.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (frame.width)/4, height: frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        

        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
        
    }
    
    var horizontalBarLeftConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addSubview(horizontalBarView)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
         horizontalBarLeftConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let x = CGFloat(indexPath.item) * (frame.width / 4)
//        horizontalBarLeftConstraint?.constant = x
//        
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
      
        
        if indexPath.item == 0 {
        homeController?.testButton.isHidden = false
        } else if indexPath.item == 1 {
            homeController?.testButton.isHidden = true
            
        } else if indexPath.item == 2 {
            homeController?.testButton.isHidden = true
            
        } else {
            homeController?.testButton.isHidden = false
            
        }
        
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
    
    let menuBarImages = ["home", "trending", "subscriptions", "account"]
    
    var homeController: HomeController?
    
    
    
    
    
    
    
    
    class MenuCell: BaseCell {
    
        let imageView: UIImageView = {
            
            
            let iv = UIImageView()
            iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
            iv.tintColor = UIColor(red: 91/250, green: 13/250, blue: 14/250, alpha: 1)
            return iv
            
            
            
        }()
        
//        override var isHighlighted: Bool {
//            didSet {
//                imageView.tintColor = isHighlighted ? UIColor.white : UIColor(red: 91/250, green: 13/250, blue: 14/250, alpha: 1)
//            }
//        }
        
        override var isSelected: Bool {
            didSet {
                imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 91/250, green: 13/250, blue: 14/250, alpha: 1)
            }
        }
        
        
        override func setupViews(){
            super.setupViews()
            
            addSubview(imageView)
            addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
            addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
            
            addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self
                , attribute: .centerY, multiplier: 1, constant: 0))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
