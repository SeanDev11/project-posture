//
//  AllExercises.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 24.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit


class AllExercises {
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var array: [ExerciseObject] = []
    
    
    init() {
        fillArray()
        
        
    }
    
    func searchExercises(forThis: String) -> ExerciseObject {
        
        
        
         for x in 0...(array.count - 1) {
            
            if forThis == array[x].name {
            
            return array[x]
            
        }
        
        }
        
        return dummyExercise
    }
    
    let dummyExercise: ExerciseObject = ExerciseObject(name: "ERROR", duration: 0, anteriorPelvicTilt: false, forwardNeck: false, roundedShoulders: false, noEquipment: false, pullUp: true, resistanceBand: true, broomstick: true, switchSides: false, topTips: "Error\nError\nError", videoThumbnail: "")
    
    
    
    func fillArray() {
        
        let wallSlides = ExerciseObject(name: "Wall Slides", duration: 60, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Maintain contact with the wall\nwith your hands, elbows and shoulders\n2. Keep your shoulders depressed during the motion", videoThumbnail: "WallSlidesTN")
        wallSlides.videoLink = Bundle.main.path(forResource: "WallSlides", ofType: "mp4")
        
        array.append(wallSlides)
        
        let heelSquat = ExerciseObject(name: "Heel Squat", duration: 30, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Stretch out your arms for\nbalance\n2. Keep your heels on the ground\n3. As you progress try to keep your back straight", videoThumbnail: "HeelSquatTN")
        
        let screenH = UIScreen.main.bounds.height
        if screenH > 700 && screenH < 800 {
            heelSquat.topTips = "1. Stretch out your arms for balance\n2. Keep your heels on the ground\n3. As you progress try to keep your back straight"
        }
        
        
        heelSquat.videoLink = Bundle.main.path(forResource: "HeelSquat", ofType: "mp4")
        
        array.append(heelSquat)


        
        
        let broomstickY = ExerciseObject(name: "Lying Y's", duration: 60, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Open up your chest by lifting the sternum\n2. The main rotation should be in your upper, not lower body", videoThumbnail: "LyingYTN")
        broomstickY.videoLink = Bundle.main.path(forResource: "LyingY", ofType: "mp4")
        
        array.append(broomstickY)

        
        let shoulderDislocations = ExerciseObject(name: "Shoulder 360's", duration: 30, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: false, pullUp: false, resistanceBand: false, broomstick: true, switchSides: false, topTips: "1. Grip the bar as wide as you have to\n2. Keep your shoulders depressed during the movement", videoThumbnail: "ShoulderDislocationsTN")
        shoulderDislocations.videoLink = Bundle.main.path(forResource: "ShoulderDislocations", ofType: "mp4")
        
        array.append(shoulderDislocations)

        let sprinterLunge = ExerciseObject(name: "Sprinter Lunge", duration: 60, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: true, topTips: "1. Squeeze glutes at the top\n2. Maintain a relatively straight back\n3. Add weights as you progress", videoThumbnail: "sprinterLungeTN")
        sprinterLunge.videoLink = Bundle.main.path(forResource: "SprinterLunge", ofType: "mp4")

        array.append(sprinterLunge)

        let floorReach = ExerciseObject(name: "Floor Reach", duration: 30, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Arch your lower back before you begin\n2. Reach towards the floor as far as you can maintaining a straight back", videoThumbnail: "FloorReachTN")
        floorReach.videoLink = Bundle.main.path(forResource: "FloorReach", ofType: "mp4")
        
        array.append(floorReach)
        
        let lyingCrossover = ExerciseObject(name: "Lying Crossover", duration: 60, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: true, topTips: "1. Pull on the one leg with your hands\n2. Push on the other leg's knee with your elbow", videoThumbnail: "LyingCrossoverTN")
        lyingCrossover.videoLink = Bundle.main.path(forResource: "LyingCrossover", ofType: "mp4")
        
        array.append(lyingCrossover)

//        Make switch sides property
        
        let chestStretch = ExerciseObject(name: "Chest Stretch", duration: 60, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: true, topTips: "1. Only your fingertips should touch the doorframe\n2. Try to rotate your upper body away from the arm on the doorframe", videoThumbnail: "ChestStretchTN")
        chestStretch.videoLink = Bundle.main.path(forResource: "ChestStretch", ofType: "mp4")
        
        array.append(chestStretch)
        
        let latStretch = ExerciseObject(name: "Lat Stretch", duration: 60, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: true, topTips: "1. Cross the leg closest to the wall behind the other one\n2. Sink into the stretch by leaning your hips towards the wall", videoThumbnail: "LatStretchTN")
        latStretch.videoLink = Bundle.main.path(forResource: "LatStretch", ofType: "mp4")

        array.append(latStretch)
        
        let lungeStretch = ExerciseObject(name: "Lunge Stretch", duration: 60, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: true, topTips: "1. Maintain a relatively straight\nback\n2. Engage your glutes", videoThumbnail: "LungeStretchTN")
        lungeStretch.videoLink = Bundle.main.path(forResource: "LungeStretch", ofType: "mp4")

        array.append(lungeStretch)
        
        let wallBrace = ExerciseObject(name: "Wall Brace", duration: 30, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Let your chest 'drop' towards the floor\n2. Tuck your chin", videoThumbnail: "WallBraceTN")
        wallBrace.videoLink = Bundle.main.path(forResource: "WallBrace", ofType: "mp4")

        array.append(wallBrace)
        
        
        
        let butterflyStretch = ExerciseObject(name: "Butterfly Stretch", duration: 60, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Gently push down on your legs with your elbows\n2. Increase difficulty by leaning forward with a straight back", videoThumbnail: "ButterflyStretchTN")
        butterflyStretch.videoLink = Bundle.main.path(forResource: "ButterflyStetch", ofType: "mp4")
        
        array.append(butterflyStretch)
        
        
        let gluteBridge = ExerciseObject(name: "Glute Bridge", duration: 60, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, pullUp: false, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Firmly contract your glutes at the top of each rep\n2. There should be no arch in your back when it touches the floor", videoThumbnail: "GluteBridgeTN")
        gluteBridge.videoLink = Bundle.main.path(forResource: "GluteBridge", ofType: "mp4")
        
        array.append(gluteBridge)
        
        let facePull = ExerciseObject(name: "Face Pull", duration: 60, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: false, pullUp: false, resistanceBand: true, broomstick: false, switchSides: false, topTips: "1. Try to point your thumbs behind you\n2. Hold the position shortly at peak contraction\n3. Tuck your chin", videoThumbnail: "FacePullsTN")
        facePull.videoLink = Bundle.main.path(forResource: "FacePulls", ofType: "mp4")
        
        array.append(facePull)
        
        let resistanceYt = ExerciseObject(name: "Band Y to T", duration: 60, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: false, pullUp: false, resistanceBand: true, broomstick: false, switchSides: false, topTips: "1. Pull your shoulder blades down and back during each rep\n2. Try to point your thumbs back\n3. Tuck your chin", videoThumbnail: "BandYTTN")
        resistanceYt.videoLink = Bundle.main.path(forResource: "BandYtoT", ofType: "mp4")
        
        array.append(resistanceYt)
        
        let barHang = ExerciseObject(name: "Bar Hang", duration: 60, anteriorPelvicTilt: true, forwardNeck: true, roundedShoulders: true, noEquipment: false, pullUp: true, resistanceBand: false, broomstick: false, switchSides: false, topTips: "1. Contract your shoulder blades down and back\n2. Engage your abs and glutes\n3. Tuck your chin", videoThumbnail: "HangTN")
        barHang.videoLink = Bundle.main.path(forResource: "Hang", ofType: "mp4")
        
        array.append(barHang)
        

    }
    
    
    
  
    
    
    
}
