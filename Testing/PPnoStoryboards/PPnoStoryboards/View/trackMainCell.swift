//
//  favoritesMainCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import CoreData


class trackMainCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    lazy var collectionViewVertical: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let addPictureButton: UIButton = {
        let screenHeight = UIScreen.main.bounds.height
        
        let button = UIButton()
        button.setTitle("Add Progress Picture", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        if screenHeight > 850 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)

        } else if screenHeight > 800 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
        } else if screenHeight > 600 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
            
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
            
        }
        
        button.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        
        button.addTarget(self, action: #selector(TrackController.capture), for: .touchUpInside)
        
        return button
        
        
    }()
    

    
    override func setupViews() {
        super.setupViews()
        
  
        addSubview(collectionViewVertical)
        
        addSubview(addPictureButton)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionViewVertical)
        
        let screenH = UIScreen.main.bounds.height
        if screenH > 850 {
            addConstraintsWithFormat(format: "V:|[v0][v1(45)]-6-|", views: collectionViewVertical, addPictureButton)
        } else if screenH > 800 {
            addConstraintsWithFormat(format: "V:|[v0][v1(43)]-6-|", views: collectionViewVertical, addPictureButton)
        } else if screenH > 600 {
            addConstraintsWithFormat(format: "V:|[v0][v1(38)]|", views: collectionViewVertical, addPictureButton)
        } else {
            addConstraintsWithFormat(format: "V:|[v0][v1(30)]|", views: collectionViewVertical, addPictureButton)
        }
        addConstraintsWithFormat(format: "H:|[v0]|", views: addPictureButton)
        
        
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        

        collectionViewVertical.register(NoContentCell.self, forCellWithReuseIdentifier: "NoPictures")
        collectionViewVertical.register(progressPicturesCell.self, forCellWithReuseIdentifier: "progressPicturesCell")
        
        collectionViewVertical.register(ProgressSwipeable.self, forCellWithReuseIdentifier: "ProgressSwipe")
        
    }
    
    
    public func reloadImages() {
        collectionViewVertical.reloadData()
        SVProgressHUD.dismiss()
        
        doNotAnimateAndScroll = false
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if onlyForLoading.allImagesArray.count == 0 {
            return 1
        } else {
        return onlyForLoading.allImagesArray.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      let theCount = onlyForLoading.allImagesArray.count
        let subscriptForArray = theCount - 1
        
        
        if theCount > 0 {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressPicturesCell", for: indexPath) as! progressPicturesCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressSwipe", for: indexPath) as! ProgressSwipeable
            cell.delegate = self
        if let theData = onlyForLoading.allImagesArray[subscriptForArray - indexPath.item].imageData {
            cell.pictureImageView.image = UIImage(data: theData as Data)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        if let thumb = onlyForLoading.allImagesArray[subscriptForArray - indexPath.item].thumbnail {
            
            let date = Date(timeIntervalSince1970: thumb.id)
            let stringDate = dateFormatter.string(from: date)
            cell.dateLabel.text = stringDate
            
            cell.workoutsLabel.text = "\(thumb.workoutNumber) Workouts"
        }
        
            return cell
        
    } else {
            let cellNo = collectionView.dequeueReusableCell(withReuseIdentifier: "NoPictures", for: indexPath) as! NoContentCell
            cellNo.mainLabel.text = "No Pictures"
            
            return cellNo
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size: CGSize
    
        let screenHeight = UIScreen.main.bounds.height
        let theCount = onlyForLoading.allImagesArray.count
        
        if theCount > 0 {
        size = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width - 15) * (4/3))
        } else {
            let width = UIScreen.main.bounds.width
            if screenHeight > 800 {
            size = CGSize(width: width, height: screenHeight - 200 )
            } else {
                size = CGSize(width: width, height: UIScreen.main.bounds.height - 135)
            }
        }

        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}




extension trackMainCell: SwipeCellVerticalDelegate {
    
    func hiddenContainerViewTappedVertical(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionViewVertical.indexPath(for: cell) else { return }
        
        
        
        
        let fetchRequest: NSFetchRequest<FullRes> = FullRes.fetchRequest()
        let fetchRequestTwo: NSFetchRequest<Thumbnail> = Thumbnail.fetchRequest()
        
        do {
            let result = try PersistenceService.contextReal.fetch(fetchRequest)
            let resultTwo = try PersistenceService.contextReal.fetch(fetchRequestTwo)
            let toBeDeleted = result[indexPath.item]
            let toBeDeletedTwo = resultTwo[indexPath.item]
            PersistenceService.contextReal.delete(toBeDeleted)
            PersistenceService.contextReal.delete(toBeDeletedTwo)
            PersistenceService.saveContext()
            //            self.collectionView.reloadData()
        } catch {
            
            
        }
        
        onlyForLoading.allImagesArray.remove(at: indexPath.item)
        
        
        
        
        
        
        collectionViewVertical.performBatchUpdates({
            self.collectionViewVertical.deleteItems(at: [indexPath])
            
            if onlyForLoading.allImagesArray.count == 0 {
                let iD = IndexPath(item: 0, section: 0)
                self.collectionViewVertical.insertItems(at: [iD])
                
            }
        })
    }
    
    func visibleContainerViewTappedVertical(inCell cell: UICollectionViewCell) {
        
        
    }
    
    func cancelViewTappedVertical(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionViewVertical.indexPath(for: cell) else { return }
        let theCell = collectionViewVertical.cellForItem(at: indexPath) as! ProgressSwipeable
        theCell.scrollToLeftVertical()
        
    }
}
