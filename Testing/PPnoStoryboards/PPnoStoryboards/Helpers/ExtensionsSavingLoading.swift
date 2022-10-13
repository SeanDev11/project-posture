//
//  ExtensionsSavingLoading.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 20.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SVProgressHUD

extension TrackController {
    func coreDataSetup() {
        saveQueue.sync() {
            
//            self.managedContext = AppDelegate().persistentContainer.viewContext
            self.managedContext = PersistenceService.contextReal
        }
    }
}



extension TrackController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerSetup() {
        imagePicker.delegate = self

        imagePicker.sourceType = UIImagePickerController.SourceType.camera
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] {
            let image: UIImage = pickedImage as! UIImage
            prepareImageForSaving(image: image)
        }
        

        self.dismiss(animated: true, completion: nil)
        SVProgressHUD.show()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension TrackController {
    
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
            
            self.saveImage(imageData: imageData as NSData, thumbnailData: thumbnailData as NSData, date: date)
        }
        
        
        
    }
}


extension CGSize {
    
    func resizeFill(toSize: CGSize) -> CGSize {
        
        let scale : CGFloat = (self.height / self.width) < (toSize.height / toSize.width) ? (self.height / toSize.height) : (self.width / toSize.width)
        return CGSize(width: (self.width / scale), height: (self.height / scale))
        
    }
}

extension UIImage {
    
    func scale(toSize newSize:CGSize) -> UIImage {
        
        // make sure the new size has the correct aspect ratio
        let aspectFill = self.size.resizeFill(toSize: newSize)
        
        UIGraphicsBeginImageContextWithOptions(aspectFill, false, 0.0);
        
        self.draw(in: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width - 65), height: (4/3) * (UIScreen.main.bounds.width - 65)))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}



extension TrackController {
    
    
    
    func saveImage(imageData: NSData, thumbnailData: NSData, date: Double) {
        
        saveQueue.sync {
            
            guard let moc = self.managedContext else {
                return
            }
            
            guard let fullRes = NSEntityDescription.insertNewObject(forEntityName: "FullRes", into: moc) as? FullRes, let thumbnail = NSEntityDescription.insertNewObject(forEntityName: "Thumbnail", into: moc) as? Thumbnail else {
                // handle failed new object in moc
                print("moc error")
                return
            }
            
            //set image data of fullres
            fullRes.imageData = imageData
            
            //set image data of thumbnail
            thumbnail.imageData = thumbnailData
            thumbnail.id = date
            thumbnail.fullRes = fullRes
            thumbnail.workoutNumber = Int16(defaults.integer(forKey: "TotalWorkouts"))
            // save the new objects
            do {
                try moc.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
            // clear the moc
            moc.refreshAllObjects()
            self.fillDataArray()
        }
        
    
        
        
    }
}





extension TrackController {
    
    func loadImages(fetched: @escaping (_ images: [FullRes]?) -> Void) {
        
//        saveQueue.async() {
            guard let moc = self.managedContext else {
                return
            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FullRes")
            
            do {
                let results = try moc.fetch(fetchRequest)
                let imageData = results as? [FullRes]
                
               DispatchQueue.main.async {
                    fetched(imageData)
                    
              }
                
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
                return
            }
        DispatchQueue.main.async {
            self.reloadEverything()
        }
        
        }
    }
//}
