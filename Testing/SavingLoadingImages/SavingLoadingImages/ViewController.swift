//
//  ViewController.swift
//  SavingLoadingImages
//
//  Created by Sean Devine on 18.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit
import CoreData
import Dispatch


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePickerSetup()
        coreDataSetup()
        
        setupViews()
    }

    
    func setupViews() {
        
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (4 / 3) * (UIScreen.main.bounds.width - 65)).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 65)).isActive = true
        
        
        view.addSubview(buttonOne)
        buttonOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        buttonOne.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(buttonTwo)
        buttonTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        buttonTwo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(nextButton)
        nextButton.leftAnchor.constraint(equalTo: buttonOne.rightAnchor,constant: 5).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10)
        
        
    }
    
    let nextButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Try Progress", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(presentNextController), for: .touchUpInside)
        return btn
    }()

    @objc func presentNextController() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let theNextOne = MainView(collectionViewLayout: layout)
        present(theNextOne, animated: true, completion: nil)
    }
    
    
    

    let imagePicker = UIImagePickerController()
    let convertQueue = DispatchQueue(label: "convertQueue", attributes: .concurrent)
    let saveQueue = DispatchQueue(label: "saveQueue", attributes: .concurrent)
    var managedContext: NSManagedObjectContext?
    
    @objc func capture() {
        present(imagePicker, animated: true)
    }
    
    @objc func loadTheImages() {
print("TRYING")
        loadImages { (images) -> Void in
            if let thumbnailData = images?.last?.thumbnail?.imageData {
                let image = UIImage(data: thumbnailData as Data)
                self.imageView.image = image
            }
        }

    }
    
    let imageView: UIImageView = {
        
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    let buttonOne: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Light-S-2"), for: .normal)
        btn.addTarget(self, action: #selector(capture), for: .touchUpInside)
        return btn
    }()
    
    let buttonTwo: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Light-S"), for: .normal)
        btn.addTarget(self, action: #selector(loadTheImages), for: .touchUpInside)
        return btn
    }()
}






extension ViewController {
    func coreDataSetup() {
        saveQueue.sync() {
            
            self.managedContext = AppDelegate().persistentContainer.viewContext
            
        }
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerSetup() {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("WAS CALLED")
        
        self.dismiss(animated: true, completion: nil)
        
        prepareImageForSaving(image: image)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("SECOND ONE")
        if let pickedImage = info[.originalImage] {
            let image: UIImage = pickedImage as! UIImage
            prepareImageForSaving(image: image)
        }
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }

    
    
}


extension ViewController {
    
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



extension ViewController {
    
    
    
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
            
            // save the new objects
            do {
                try moc.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
            // clear the moc
            moc.refreshAllObjects()
            
        }
        
        

    }
}





extension ViewController {
    
    func loadImages(fetched: @escaping (_ images: [FullRes]?) -> Void) {
        
        saveQueue.async() {
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
        }
    }
}
