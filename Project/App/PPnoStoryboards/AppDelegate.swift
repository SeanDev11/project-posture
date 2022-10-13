//
//  AppDelegate.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        
        window?.rootViewController = CustomTabBarController()
        
        
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        ResettingValues.resetDailyProgress()
        
        WeeklyService.newWeek()
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
        if defaults.array(forKey: "StreakArray") == nil {
            defaults.set([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], forKey: "StreakArray")
        }
        
        
        AppDelegate.scheduleNotification()
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSessionCategoryPlayback error")
        }
        
        ResettingValues.resetDailyProgress()
        WeeklyService.newWeek()
    }
    
    
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        PersistenceService.saveContext()
    }
    
    // MARK: - Core Data stack
    
    
   static func scheduleNotification() {
    
    let center = UNUserNotificationCenter.current()
    
    center.removeAllPendingNotificationRequests()
    
    
    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if granted {
            defaults.set(false, forKey: "DailyReminder")
            accessGranted = true
            
        } else {

            defaults.set(false, forKey: "DailyReminder")
            
        }
    }
    
    
        let content = UNMutableNotificationContent()
        content.title = "Daily Reminder"
        content.body = "Improve your posture today!"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        
        var dateComponents = DateComponents()
        dateComponents.hour = defaults.integer(forKey: "ReminderHour")
        dateComponents.minute = defaults.integer(forKey: "ReminderMinute")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    
        
        let request = UNNotificationRequest(identifier: "DailyReminder", content: content, trigger: trigger)
        center.add(request)
    
    
    }
    
    static var accessGranted = false
    static func checkForAccess() {
        var settingsss: Int = 0
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (UNNotificationSettings) in
             settingsss = UNNotificationSettings.authorizationStatus.rawValue
            if settingsss == 2 {
                accessGranted = true
            } else { accessGranted = false }
            

        }
    }
    
    static func clearNotifications() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        
    }

}

