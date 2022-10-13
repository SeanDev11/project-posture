//
//  SettingPopUp.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 25.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class SettingPopUp: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        useSparinglyGenerateControllerGlobal.tabBarController?.tabBar.isHidden = true
        useSparinglyTrackGlobal.tabBarController?.tabBar.isHidden = true
        useSparinglyFavoriteGlobal.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    var hour: Int = 0
    var minutes: Int = 0

    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 1
        case 2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if component == 1 {
            return 40
        } else {
        return 40
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if component == 1 {
            return 14
        } else {
        return 45
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            var displayedNumberString = "\(row)"
            if row < 10 {
                displayedNumberString = "0\(displayedNumberString)"
            }
            return displayedNumberString
        case 1:
            return ":"
        case 2:
            var displayedString = "\(row)"
            if row < 10 {
                displayedString = "0\(displayedString)"
            }
            return displayedString
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 2:
            minutes = row
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.87)
        
        view.isOpaque = false
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        
        reminderCheckbox.isOn = defaults.bool(forKey: "DailyReminder")
        pickerView.selectRow(defaults.integer(forKey: "ReminderHour"), inComponent: 0, animated: true)
        pickerView.selectRow(defaults.integer(forKey: "ReminderMinute"), inComponent: 2, animated: true)
        createPopUpTime()
   
    }
    
    func createPopUpTime() {
        
        view.addSubview(popUp)
        
        
        popUp.addSubview(titleLabel)
        popUp.addSubview(pickerView)
        popUp.addSubview(dailyReminder)
        popUp.addSubview(reminderCheckbox)
        
        
        
        popUp.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        popUp.addConstraintsWithFormat(format: "V:|-14-[v0]", views: titleLabel)
        
        var height = UIScreen.main.bounds.height / 2.5
        if UIScreen.main.bounds.height > 850 {
            height = UIScreen.main.bounds.height / 2.3
        } else {
            height = UIScreen.main.bounds.height / 2
        }
        
        var dailyReminderTopConstant: CGFloat = height / 4.8
        var pickerViewTopConstant: CGFloat = 12
        if UIScreen.main.bounds.height > 850 {
            dailyReminderTopConstant = dailyReminderTopConstant + 1 - 1
            pickerViewTopConstant = 8
        }
        
        popUp.addConstraintsWithFormat(format: "V:|-\(dailyReminderTopConstant)-[v0]", views: dailyReminder)
        popUp.addConstraintsWithFormat(format: "H:|-15-[v0]", views: dailyReminder)
        
        popUp.addConstraintsWithFormat(format: "H:[v0]-10-|", views: reminderCheckbox)
        popUp.addConstraint(NSLayoutConstraint(item: reminderCheckbox, attribute: .centerY, relatedBy: .equal, toItem: dailyReminder, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        
        
        
        
        
//        popUp.addConstraint(NSLayoutConstraint(item: pickerView, attribute: .centerY, relatedBy: .equal, toItem: popUp, attribute: .centerY, multiplier: 1, constant: 10))
        
        
        
        
        
//        pickerView.heightAnchor.constraint(equalToConstant: height / 1.7).isActive = true
        
        
        
        popUp.addSubview(checkButton)
        popUp.addSubview(cancelButton)
 
        popUp.addConstraintsWithFormat(format: "H:|-10-[v0]", views: checkButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: checkButton)
        
        popUp.addConstraintsWithFormat(format: "H:[v0]-10-|", views: cancelButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: cancelButton)
        
        
        
        popUp.addConstraint(NSLayoutConstraint(item: checkButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 2/3.3, constant: 0))
        popUp.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 1/3.3, constant: 0))
        
        
        popUp.addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: pickerView)
        pickerView.topAnchor.constraint(equalTo: dailyReminder.bottomAnchor,constant: pickerViewTopConstant).isActive = true
        
        if UIScreen.main.bounds.height < 850 {
            pickerView.bottomAnchor.constraint(equalTo: checkButton.topAnchor, constant: -12).isActive = true
        }
        
        
        
        
    }
    
    var pickerNumbers: [Int] = [5,6]
    
    func fillArray() {
        
        for x in 7...30 {
            
            pickerNumbers.append(x)
            
        }
    }
    
    let popUp: UIView = {
        
        let xcoord = UIScreen.main.bounds.width / 9
        
        var ycoord = UIScreen.main.bounds.height / 6
        
        let width = UIScreen.main.bounds.width * (7 / 9)
        
        var height = UIScreen.main.bounds.height / 2.5
        if UIScreen.main.bounds.height > 850  {
            height = UIScreen.main.bounds.height / 2.3
            
            ycoord = ycoord + 60
        } else {
            height = UIScreen.main.bounds.height / 2
        }
        
        
        let view = UIView(frame: CGRect(x: xcoord, y: ycoord, width: width, height: height))
        
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        return view
    }()
    
    let reminderCheckbox: UISwitch = {
        
        let cb = UISwitch()
        
        cb.isOn = false
        cb.translatesAutoresizingMaskIntoConstraints = false
        
       return cb
    }()
    
    let titleLabel: UILabel = {
        
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontSize: CGFloat = 25
        if screenH > 850 {
            fontSize = 35
        } else if screenH > 800 {
            fontSize = 35
        } else if screenH > 700 {
            fontSize = 33
        } else if screenH > 600 {
            fontSize = 32
        } else {
            fontSize = 28
        }
        
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    let dailyReminder: UILabel = {
        
        let label = UILabel()
        label.text = "Daily Reminder"
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false

        
       return label
    }()
    
    
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    let checkButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Save Changes", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 14
        
         button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        return button
    }()
    
    let cancelButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1), for: .normal)
        button.backgroundColor = UIColor.clear
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        button.layer.cornerRadius = 14
        
        return button
    }()
    
    @objc func dismissPopUp() {
        
        reminderCheckbox.setOn(defaults.bool(forKey: "DailyReminder"), animated: true)
        
        pickerView.selectRow(defaults.integer(forKey: "ReminderHour"), inComponent: 0, animated: false)
        pickerView.selectRow(defaults.integer(forKey: "ReminderMinute"), inComponent: 2, animated: false)
        
        
        
        
        dismiss(animated: true)
        
        globalSettingsIsLaunched = false
        
        useSparinglyGenerateControllerGlobal.tabBarController?.tabBar.isHidden = false
        useSparinglyTrackGlobal.tabBarController?.tabBar.isHidden = false
        useSparinglyFavoriteGlobal.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func saveChanges() {
        
        var enteredTheChecker: Bool = false
        
        defaults.set(reminderCheckbox.isOn, forKey: "DailyReminder")
        defaults.set(pickerView.selectedRow(inComponent: 0), forKey: "ReminderHour")
        defaults.set(pickerView.selectedRow(inComponent: 2), forKey: "ReminderMinute")
        
        AppDelegate.checkForAccess()
        usleep(100000)
        let accessGranted = AppDelegate.accessGranted
        if accessGranted == false && reminderCheckbox.isOn == true {
            
            enteredTheChecker = true
            
            defaults.set(false, forKey: "DailyReminder")
            reminderCheckbox.setOn(false, animated: false)
            let alertController = UIAlertController (title: "Notifications are Disabled", message: "Go to Settings?", preferredStyle: .alert)
            
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
                (_) -> Void in
                
                self.dismissThePopUp()
                
            }
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
            
        }
        
        if accessGranted {
        if reminderCheckbox.isOn {
            
            AppDelegate.scheduleNotification()
            dismissThePopUp()
        } else {
            AppDelegate.clearNotifications()
            dismissThePopUp()
        }
        } else if reminderCheckbox.isOn == false && accessGranted == false {
            if enteredTheChecker == false {
            dismissThePopUp()
            }
        }

        
        
        
    }
    
    func dismissThePopUp() {
        dismiss(animated: true)
        
        globalSettingsIsLaunched = false
        useSparinglyGenerateControllerGlobal.tabBarController?.tabBar.isHidden = false
        useSparinglyTrackGlobal.tabBarController?.tabBar.isHidden = false
        useSparinglyFavoriteGlobal.tabBarController?.tabBar.isHidden = false
    }
  
}
