//
//  MainView.swift
//  SavingLoadingImages
//
//  Created by Sean Devine on 20.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        
        
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(ProgressCells.self, forCellWithReuseIdentifier: "Progress")
        
        
    
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
        
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Progress", for: indexPath)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size: CGSize
        
        size = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width - 15) * (4/3))
        
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    let convertQueue = DispatchQueue(label: "convertQueue", attributes: .concurrent)
    
    
    //    let saveQueue = dispatch_queue_create("saveQueue", DISPATCH_QUEUE_CONCURRENT)
    
    let saveQueue = DispatchQueue(label: "saveQueue", attributes: .concurrent)
    var managedContext: NSManagedObjectContext?
    
    
}























extension MainView {
    
    func prepareImageForSaving(image: UIImage) {
        
        let date: Double = NSDate().timeIntervalSince1970
        
        convertQueue.async() {
            
            
            guard let imageData = image.jpegData(compressionQuality: 1) else {
                
                print("jpg ERROR")
                return
            }
            
            
            
            
            let thumbnail = image.scale(toSize: CGSize(width: UIScreen.main.bounds.width - 65, height: (4/3) * (UIScreen.main.bounds.width - 65)))
            
            guard let thumbnailData = thumbnail.jpegData(compressionQuality: 0.7) else {
                print("jpg ERROR")
                
                return
            }
            
//            self.saveImage(imageData: imageData as NSData, thumbnailData: thumbnailData as NSData, date: date)
        }
        
        
        
    }
}
