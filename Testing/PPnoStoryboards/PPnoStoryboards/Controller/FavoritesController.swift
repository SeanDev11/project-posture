//
//  FavoritesController.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class FavoritesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        settingsPopUp.modalPresentationStyle = .overCurrentContext

        setupCollectionView()

        setupNavBar()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            let fav = try PersistenceService.contextReal.fetch(fetchRequest)
            self.allFavorites = fav
            
            self.collectionView.reloadData()
        } catch {
            
            
        }
        
        
    }
    
    var allFavorites = [Favorite]()
    
    private func setupCollectionView() {
        
        
//        collectionView.register(favoritesSubCell.self, forCellWithReuseIdentifier: "favoritesSubCell")
        collectionView.register(FavoriteCellSwipe.self, forCellWithReuseIdentifier: "FavSwipe")
        collectionView.register(NoContentCell.self, forCellWithReuseIdentifier: "NoFavorites")
        
        //        WORK on this ADAPTABLE based on generateBUtton
        if UIScreen.main.bounds.height > 800 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        } else if UIScreen.main.bounds.height > 600 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        } else {
            
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            
        }
        
        collectionView.backgroundColor = UIColor.white
       
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    

    private func setupNavBar() {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: view.frame.height))
        titleLabel.text = "P|P"
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        titleLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "SettingsIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
      
        
        navigationItem.rightBarButtonItem = moreButton
        
        
    }
    
    @objc func handleMore() {
        
        
        if globalSettingsIsLaunched == false {
            self.present(settingsPopUp, animated: true)
            globalSettingsIsLaunched = true
        }
    }
    
 
   
    
    private func convertToExercise(nameArray: [NSString]) -> [ExerciseObject] {
        var finalArray: [ExerciseObject] = []
        
        for x in nameArray {
            finalArray.append(allExercises.searchExercises(forThis: x as String))
        }
        
        return finalArray
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if allFavorites.count == 0 {
            return 1
        } else {
            return allFavorites.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if allFavorites.count > 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavSwipe", for: indexPath) as! FavoriteCellSwipe
        
        cell.delegate = self
            
        cell.scrollToLeftNonAnimated()
        cell.favoriteNameLabel.text = allFavorites[indexPath.item].name
        cell.durationLabel.text = "\(allFavorites[indexPath.item].duration) minutes"
        
        
        
        return cell
        } else {
            let cellNo = collectionView.dequeueReusableCell(withReuseIdentifier: "NoFavorites", for: indexPath)


            return cellNo
        }
 
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size: CGSize
        let screenH = UIScreen.main.bounds.height
        
        if allFavorites.count > 0 {
            if screenH > 850 {
        size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
            } else  if screenH > 800 {
                size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 7.4)
            } else if screenH > 700 {
                size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.9)
            } else {
                size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6)
            }
        } else {
            size = CGSize(width: UIScreen.main.bounds.width, height: self.view.bounds.height)
        }
        
        
        return size
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
}







extension FavoritesController: SwipeableCollectionViewCellDelegate {
    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            let result = try PersistenceService.contextReal.fetch(fetchRequest)
            let toBeDeleted = result[indexPath.item]
            PersistenceService.contextReal.delete(toBeDeleted)
            PersistenceService.saveContext()
//            self.collectionView.reloadData()
        } catch {
            
            
        }
 
        allFavorites.remove(at: indexPath.item)
        
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
            if allFavorites.count == 0 {
                let iD = IndexPath(item: 0, section: 0)
                self.collectionView.insertItems(at: [iD])

            }
        })
    }
    
    
    func visibleContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        if allFavorites.count > 0 {
            let layoutFav = UICollectionViewFlowLayout()
            layoutFav.scrollDirection = .vertical
            layoutFav.minimumLineSpacing = 0
            currentWorkoutArray = convertToExercise(nameArray: allFavorites[indexPath.item].workoutArray)
            
            let favoriteView = GeneratedRoutineView(collectionViewLayout: layoutFav)
            navigationController?.pushViewController(favoriteView, animated: true)
        }
    }
    
    func cancelViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let theCell = collectionView.cellForItem(at: indexPath) as! FavoriteCellSwipe
        theCell.scrollToLeft()
        
    }
}
