//
//  generatedRoutineView.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 12.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
import Foundation
import UIKit

class GeneratedRoutineView: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupCollectionView()
        makeButton()
        
        
        setupNavBar()
        
    }
    
    func setupNavBar() {
        
        let titleLabel = UILabel()
        titleLabel.text = "P|P"
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        titleLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem?.isEnabled = true
        navigationItem.hidesBackButton = false
        
        
    }
    
    let cellId = "workoutExercisesCell"
    let screenHeight = UIScreen.main.bounds.height
    
    
    
    lazy var startButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        if self.screenHeight > 800 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 33)
        } else if self.screenHeight > 600 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        }
        
       button.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        
        button.addTarget(self, action: #selector(startWorkout), for: .touchUpInside)
        return button
    }()
    
    private func setupCollectionView() {
        
   
        collectionView.register(workoutExercisesCell.self, forCellWithReuseIdentifier: cellId)
        
        //        WORK on this ADAPTABLE based on generateBUtton
        
        
        
        if UIScreen.main.bounds.height > 800 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
            
        } else if UIScreen.main.bounds.height > 600 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 38, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 38, right: 0)
            
        } else {
            
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
            
            
        }
        
        collectionView.backgroundColor = UIColor.white
        
        
        
    }
    
    private func setupViews() {
        
        view.addSubview(startButton)
        
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: startButton)
        if screenHeight > 800 {
            view.addConstraintsWithFormat(format: "V:[v0(43)]-80-|", views: startButton)
        } else if screenHeight > 600 {
            view.addConstraintsWithFormat(format: "V:[v0(38)]-49-|", views: startButton)
        } else {
            view.addConstraintsWithFormat(format: "V:[v0(30)]-49-|", views: startButton)
        }
        
        
        
        
    }
    
    private func makeButton() {
        
        
        
        
    }
    
    @objc func startWorkout() {
        
       let layoutLive = UICollectionViewFlowLayout()
        layoutLive.scrollDirection = .horizontal
        layoutLive.minimumLineSpacing = 0
        
        let liveView = LiveViewController(collectionViewLayout: layoutLive)
       navigationController?.pushViewController(liveView, animated: true)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentWorkoutArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! workoutExercisesCell

        if UIScreen.main.bounds.height > 500 {
            cell.theXConstantFix = -2
            cell.makeConstraintFix()
        }
        
        let exercise = currentWorkoutArray[indexPath.item]
        cell.exerciseNameLabel.text = exercise.name
        cell.durationLabel.text = "\(exercise.duration) seconds"
        cell.videoImageView.image = UIImage(named: exercise.videoThumbnail)
        
        
        return cell
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size: CGSize
      
//        if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
//            
//            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 7)
//            
//        } else if UIScreen.main.bounds.height > 600 {
//            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.2)
//        } else {
//            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.2)
//        }
        
        
        
        if UIScreen.main.bounds.height > 880 {
            let height = UIScreen.main.bounds.height / 7.1
            
            size = CGSize(width: UIScreen.main.bounds.width, height: height + (0.1 * height))
            
        } else if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
            let height = UIScreen.main.bounds.height / 7
            
            size = CGSize(width: UIScreen.main.bounds.width, height: height + (0.1 * height))
            
        } else if UIScreen.main.bounds.height > 600 {
            
            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.2)
            
        } else {
            
            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.2)
            
        }
        
        
        return size
        
}
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if isLaunched == false {
            isLaunched = true
            currentExercise = indexPath.item
            videoLauncher.showVideoPlayer()
            
            videoLauncher.exerciseNameLabel.text = currentWorkoutArray[indexPath.item].name
            
            
            
        }
        
    }
    
    

}
