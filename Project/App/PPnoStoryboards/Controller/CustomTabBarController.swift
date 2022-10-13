//
//  CustomTabBarController.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 08.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
import Foundation
import UIKit

let settingsPopUp = SettingPopUp()
let defaults = UserDefaults.standard

//let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

let allExercises = AllExercises()
let videoLauncher = VideoLauncher()
var currentExercise: Int = 0

var currentWorkoutArray: [ExerciseObject] = allExercises.array
var currentWorkoutArrayTwo: [ExerciseObject] = []


var isLaunched = false

var globalSettingsIsLaunched = false

let layoutForGenerateGlobal = UICollectionViewFlowLayout()
var useSparinglyGenerateControllerGlobal: GenerateController = GenerateController(collectionViewLayout: layoutForGenerateGlobal)

let layoutForTrackGlobal = UICollectionViewFlowLayout()
var useSparinglyTrackGlobal: TrackController = TrackController(collectionViewLayout: layoutForTrackGlobal)

let layoutForFavoriteGlobal = UICollectionViewFlowLayout()
var useSparinglyFavoriteGlobal: FavoritesController = FavoritesController(collectionViewLayout: layoutForFavoriteGlobal)

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        //setup view controllers
        let layout = UICollectionViewFlowLayout()
        
       layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let layoutTrack = UICollectionViewFlowLayout()
        
        layoutTrack.scrollDirection = .horizontal
        layoutTrack.minimumLineSpacing = 0
        
        let layoutFavorites = UICollectionViewFlowLayout()
        
        layoutFavorites.scrollDirection = .vertical
        layoutFavorites.minimumLineSpacing = 0
        
        let generateViewController = GenerateController(collectionViewLayout: layout)
        let mainNavController = UINavigationController(rootViewController: generateViewController)
        mainNavController.tabBarItem.image = UIImage(named: "Image")
        mainNavController.tabBarItem.title = "Train"
        
        let trackController = TrackController(collectionViewLayout: layoutTrack)
        let trackNavigationController = UINavigationController(rootViewController: trackController)
        trackNavigationController.tabBarItem.image = UIImage(named: "PPBar")
        trackNavigationController.tabBarItem.title = "Track"
        
        let favoritesController = FavoritesController(collectionViewLayout: layoutFavorites)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesController)
        
        favoritesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.favorites, tag: 2)
UINavigationBar.appearance().barTintColor = UIColor(red: 153/255, green: 244/255, blue: 255/255, alpha: 1)
        
        viewControllers = [trackNavigationController, mainNavController, favoritesNavigationController]

        self.selectedViewController = mainNavController

        
    }
    
    
    
    
    
    
}
