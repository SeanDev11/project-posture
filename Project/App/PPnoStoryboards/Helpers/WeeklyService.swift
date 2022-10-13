//
//  WeeklyService.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 17.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class WeeklyService {
    
    private init() {}
    
    static var allWeeklyServices = [WeeklyProgress]()
    
    
    static func newWeek() {
        
        let initialRequest: NSFetchRequest<WeeklyProgress> = WeeklyProgress.fetchRequest()
        
        do {
            let week = try PersistenceService.contextReal.fetch(initialRequest)
            self.allWeeklyServices = week
        } catch {}
        

        if defaults.integer(forKey: "DaysSinceNewWeek") == 7 || allWeeklyServices.count == 0 {

            defaults.set(0, forKey: "DaysSinceNewWeek")
            
        let fetchRequest: NSFetchRequest<WeeklyProgress> = WeeklyProgress.fetchRequest()
        
            let newWeek: WeeklyProgress = WeeklyProgress(context: PersistenceService.contextReal)
            newWeek.weekNumber = Int16(allWeeklyServices.count + 1)
            newWeek.totalTime = 0
            
            
            PersistenceService.saveContext()
            
        do {
            let week = try PersistenceService.contextReal.fetch(fetchRequest)
            self.allWeeklyServices = week
        } catch {}

        }
    }
    
    
    static func updateThisWeek(addedTime: Int16) {
        
        
        let fetchRequest: NSFetchRequest<WeeklyProgress> = WeeklyProgress.fetchRequest()
        
        do {
            let week = try PersistenceService.contextReal.fetch(fetchRequest)
            self.allWeeklyServices = week
        } catch {}
        
        allWeeklyServices[allWeeklyServices.count - 1].totalTime = allWeeklyServices[allWeeklyServices.count - 1].totalTime + addedTime
        
        PersistenceService.saveContext()
    }
    
    
    static func getMaxValue() -> Int16 {
        
        var max: Int16 = 0
        
        if allWeeklyServices.count < 6 {
            for x in allWeeklyServices {
                if x.totalTime > max {
                    max = x.totalTime
                }
            }
        } else {
            for x in (allWeeklyServices.count - 5)...(allWeeklyServices.count - 1) {
                if allWeeklyServices[x].totalTime > max {
                    max = allWeeklyServices[x].totalTime
                }
            }
        }
        
        return max
    }
    
    
    
    
    
    
    
    
}
