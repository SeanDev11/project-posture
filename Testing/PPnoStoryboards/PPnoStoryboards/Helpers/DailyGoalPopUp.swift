//
//  DailyGoalPopUp.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 06.11.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit


class DailyGoalPopUp: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.87)
        
        view.isOpaque = false
        
        pickerView.dataSource = self
        pickerView.delegate = self
        fillArray()
        createPopUpTime()
        
    }
    
    
    func createPopUpTime() {
        
        view.addSubview(popUp)
        
        
        popUp.addSubview(titleLabel)
        popUp.addSubview(pickerView)
        
        popUp.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        popUp.addConstraintsWithFormat(format: "V:|-15-[v0]", views: titleLabel )
        
        var height = UIScreen.main.bounds.height / 2.5
        if height > 600 {
            height = 667 / 4.5
        } else {
            height = UIScreen.main.bounds.height / 2.2
        }
        
        
        pickerView.centerYAnchor.constraint(equalTo: popUp.centerYAnchor).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: popUp.centerXAnchor).isActive = true
        
        
        
        
       
        
        popUp.addSubview(checkButton)
        popUp.addSubview(cancelButton)
        
        popUp.addConstraintsWithFormat(format: "H:|-10-[v0]", views: checkButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: checkButton)
        
        popUp.addConstraintsWithFormat(format: "H:[v0]-10-|", views: cancelButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: cancelButton)
        
        
        
        popUp.addConstraint(NSLayoutConstraint(item: checkButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 2/3.3, constant: 0))
        popUp.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 1/3.3, constant: 0))
        
        pickerView.selectRow((defaults.integer(forKey: "DailyGoal") - 5), inComponent: 0, animated: true)
        
        
    }
    
    let popUp: UIView = {
        
        let xcoord = UIScreen.main.bounds.width / 9
        
        var ycoord = UIScreen.main.bounds.height / 6
        
        let width = UIScreen.main.bounds.width * (7 / 9)
        
        var height = UIScreen.main.bounds.height
        if height > 700 {
            height = 667 / 2
            
            ycoord = ycoord + 60
        } else if height > 600 {
            height = 667 / 2
            ycoord = ycoord + 10
        } else {
            height = UIScreen.main.bounds.height / 1.9
        }
        
        
        let view = UIView(frame: CGRect(x: xcoord, y: ycoord, width: width, height: height))
        
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        return view
    }()
    
    
    let titleLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        
        label.text = "Daily Goal"
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
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = UIColor.black
        label.textAlignment = .center
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
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.backgroundColor = UIColor.clear
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        button.layer.cornerRadius = 14
        
        return button
    }()
    
    @objc func dismissPopUp() {
        
        pickerView.selectRow((defaults.integer(forKey: "DailyGoal") - 5), inComponent: 0, animated: false)
        
        globalSettingsIsLaunched = false

        dismiss(animated: true)
        
        tabBarController?.tabBar.items?[0].isEnabled = true
    }
    
    @objc func saveChanges() {
        
        defaults.set(dailyGoalTemp, forKey: "DailyGoal")
        Streak.update()
        
        
        globalSettingsIsLaunched = false

        dismiss(animated: true)
        
        useSparinglyGenerateControllerGlobal.reloadDailyGoalView()
        
        
        tabBarController?.tabBar.items?[0].isEnabled = true
    }
    
    
    var dailyGoalTemp: Int = 10
    
    var pickerNumbers: [Int] = [5,6]
    
    func fillArray() {
        
        for x in 7...30 {
            
            pickerNumbers.append(x)
            
        }
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 26
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerNumbers[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        dailyGoalTemp = row + 5
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        var height: CGFloat = 30
        if UIScreen.main.bounds.height > 700 {
            height = 40
        } else {
            height = 30
        }
        
        
        return height
    }
    
    
}
