//
//  morningNightCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 06.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class morningNightCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let morningArray: [ExerciseObject] = [allExercises.searchExercises(forThis: "Chest Stretch"), allExercises.searchExercises(forThis: "Lat Stretch"), allExercises.searchExercises(forThis: "Wall Brace"), allExercises.searchExercises(forThis: "Floor Reach"), allExercises.searchExercises(forThis: "Lunge Stretch"), allExercises.searchExercises(forThis: "Heel Squat")]
    
    var fillingArray: [ExerciseObject] = []
    
    
    
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
        
//        currentWorkoutArray = morningArray
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)


       
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        

        collectionView.register(workoutExercisesCell.self, forCellWithReuseIdentifier: "workoutExercisesCell")
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        number of exercises in workout
        
        return fillingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workoutExercisesCell", for: indexPath) as! workoutExercisesCell
        
        cell.theXConstantFix = -6
        cell.makeConstraintFix()
        
        
        let exercise = fillingArray[indexPath.item]
        cell.exerciseNameLabel.text = exercise.name
        cell.durationLabel.text = "\(exercise.duration) seconds"
        cell.videoImageView.image = UIImage(named: exercise.videoThumbnail)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size: CGSize
        
       
        
        if UIScreen.main.bounds.height > 880 {
            
            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 7.1)
            
        } else if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
            
            
           size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 7)

        } else if UIScreen.main.bounds.height > 600 {
            
            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.2)
            
        } else {
            
            size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.2)
            
        }
        
        return size 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isLaunched == false {
            currentWorkoutArray = fillingArray
            
            isLaunched = true
            currentExercise = indexPath.item
        videoLauncher.showVideoPlayer()
    
        videoLauncher.exerciseNameLabel.text = currentWorkoutArray[currentExercise].name
            
            
            
        }
        
        
    }
    
    

    
    
    
    
}
