//
//  ResettingValues.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 09.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
import Foundation
import UIKit

class ResettingValues {
    
    private init() {}
    
    
    static func resetDailyProgress() {
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDateString: String = dateFormatter.string(from: currentDate)
        
        if defaults.string(forKey: "LastReset") != currentDateString {
            
            useSparinglyGenerateControllerGlobal.scrollToMenuIndex(menuIndex: 1)
            
            Streak.next()
            
            let daysSinceNewWeek = defaults.integer(forKey: "DaysSinceNewWeek")
            defaults.set(daysSinceNewWeek + 1, forKey: "DaysSinceNewWeek")
            
            
            
            defaults.set(0, forKey: "DailyProgress")
            defaults.set(currentDateString, forKey: "LastReset")
            
            
            
            
            useSparinglyGenerateControllerGlobal.reloadDailyGoalView()
        }
        
    }
    
    
    
    
    
    
    
}
