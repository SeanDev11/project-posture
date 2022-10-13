//
//  Streak.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 16.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit


class Streak {
    
    private init() {}
    
    
    static func next() {
    
    var streakArray: [Double] = []
    
    streakArray = defaults.array(forKey: "StreakArray") as! [Double]
        
        if defaults.integer(forKey: "StreakDays") < 7 {
            
            let current = defaults.integer(forKey: "StreakDays")
            defaults.set(current + 1, forKey: "StreakDays")

        } else {
    
    streakArray.append(0.0)
    streakArray.removeFirst()
    
    defaults.set(streakArray, forKey: "StreakArray")
    
        }
    }
    
    static func update() {
        
        var streakArray: [Double] = []
        
        streakArray = defaults.array(forKey: "StreakArray") as! [Double]
        
        let percentage: Double = Double(defaults.integer(forKey: "DailyProgress")) / Double(defaults.integer(forKey: "DailyGoal"))
        
        if defaults.integer(forKey: "StreakDays") < 7 {
            let index = defaults.integer(forKey: "StreakDays")
            streakArray[index-1] = percentage
        } else {
            streakArray.removeLast()
            streakArray.append(percentage)
        }
        
        defaults.set(streakArray, forKey: "StreakArray")

    }
    
}
