//
//  PopUpEquipment.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 26.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class PopUpEquipment: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.87)
        
        view.isOpaque = false
        
        createPopUp()
        setValues()
        
    }
    
    func setValues() {
        aptCheckbox.setOn(defaults.bool(forKey: "ResistanceBand"), animated: false)
        rsCheckbox.setOn(defaults.bool(forKey: "Pullup"), animated: false)
        fnCheckbox.setOn(defaults.bool(forKey: "Broomstick"), animated: false)
    }
    
    let rsCheckboxVerticalConstant: CGFloat = {
        let screenH = UIScreen.main.bounds.height
        var constant = (UIScreen.main.bounds.height) / 14
        if screenH > 850 {
            constant = constant - 28
        } else if screenH > 800 {
            constant = constant - 25
        } else if screenH > 700 {
            constant = 32
        } else if screenH > 600 {
            constant = constant - 12
            
        } else {
            constant = constant - 12
        }
        
        return constant
    }()
    
    
    let betweenBoxesConstant: CGFloat = {
        var constantHere: CGFloat = ((UIScreen.main.bounds.height) / 12) / 1.5
        let screenH = UIScreen.main.bounds.height
        if screenH > 700 {
            constantHere = ((UIScreen.main.bounds.height) / 12) / 1.5
        } else if screenH > 600 {
            constantHere = (((UIScreen.main.bounds.height) / 12) / 1.5) + 4
        } else {
            constantHere = constantHere + 6
        }
        
        
        return constantHere
    }()
    
    let screenWidth = UIScreen.main.bounds.width
    
    func createPopUp() {
        
        view.addSubview(popUp)
        
        //        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: popUp)
        //        view.addConstraintsWithFormat(format: "V:|-100-[v0]-100-|", views: popUp)
        
        
        popUp.addSubview(titleLabel)
        
        popUp.addSubview(rsCheckbox)
        popUp.addSubview(rsLabel)
        popUp.addSubview(aptCheckbox)
        popUp.addSubview(aptLabel)
        popUp.addSubview(fnCheckbox)
        popUp.addSubview(fnLabel)
        
        popUp.addSubview(checkButton)
        popUp.addSubview(cancelButton)
        
        popUp.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        
        
        
        popUp.addConstraintsWithFormat(format: "V:|-15-[v0]", views: titleLabel)
        
        popUp.addConstraint(NSLayoutConstraint(item: rsCheckbox, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: rsCheckboxVerticalConstant))
        
        
        
        popUp.addConstraint(NSLayoutConstraint(item: rsLabel, attribute: .centerY, relatedBy: .equal, toItem: rsCheckbox, attribute: .centerY, multiplier: 1, constant: 0))
        
        popUp.addConstraintsWithFormat(format: "H:|-10-[v0]", views: rsLabel)
        
        //CHANGE
        if screenWidth > 330 {
            popUp.addConstraintsWithFormat(format: "H:[v0]-15-|", views: rsCheckbox)
        } else {
            
            popUp.addConstraintsWithFormat(format: "H:[v0]-10-|", views: rsCheckbox)
        }
        
        
        
        popUp.addConstraint(NSLayoutConstraint(item: aptLabel, attribute: .centerY, relatedBy: .equal, toItem: rsLabel, attribute: .bottom, multiplier: 1, constant: (betweenBoxesConstant)))
        
        popUp.addConstraint(NSLayoutConstraint(item: aptLabel, attribute: .left, relatedBy: .equal, toItem: rsLabel, attribute: .left, multiplier: 1, constant: 0))
        
        popUp.addConstraint(NSLayoutConstraint(item: aptCheckbox, attribute: .centerY, relatedBy: .equal, toItem: aptLabel, attribute: .centerY, multiplier: 1, constant: 0))
        
        popUp.addConstraint(NSLayoutConstraint(item: aptCheckbox, attribute: .centerX, relatedBy: .equal, toItem: rsCheckbox, attribute: .centerX, multiplier: 1, constant: 0))
        
        
        popUp.addConstraint(NSLayoutConstraint(item: fnLabel, attribute: .left, relatedBy: .equal, toItem: aptLabel, attribute: .left, multiplier: 1, constant: 0))
        
        popUp.addConstraint(NSLayoutConstraint(item: fnLabel, attribute: .centerY, relatedBy: .equal, toItem: aptLabel, attribute: .bottom, multiplier: 1, constant: betweenBoxesConstant))
        
        popUp.addConstraint(NSLayoutConstraint(item: fnCheckbox, attribute: .centerY, relatedBy: .equal, toItem: fnLabel, attribute: .centerY, multiplier: 1, constant: 0))
        
        popUp.addConstraint(NSLayoutConstraint(item: fnCheckbox, attribute: .left, relatedBy: .equal, toItem: aptCheckbox, attribute: .left, multiplier: 1, constant: 0))
        

        popUp.addConstraintsWithFormat(format: "H:|-10-[v0]", views: checkButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: checkButton)
        
        popUp.addConstraintsWithFormat(format: "H:[v0]-10-|", views: cancelButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: cancelButton)
        
        
        
        popUp.addConstraint(NSLayoutConstraint(item: checkButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 2/3.3, constant: 0))
        popUp.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 1/3.3, constant: 0))
        
        
    }
    
    let popUp: UIView = {
        
        var xcoord = UIScreen.main.bounds.width / 9
        
        var ycoord = UIScreen.main.bounds.height / 6
        
        var width = UIScreen.main.bounds.width * (7 / 9)
        
        var height = UIScreen.main.bounds.height / 2
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 850 {
            height = 690 / 2
            ycoord = ycoord + 60
        } else if screenHeight > 800 {
            height = 620 / 2
            ycoord = ycoord + 70
            
        } else if screenHeight > 700 {
            height = screenHeight / 2.4
            width = width - 10
            xcoord = xcoord + 5
        } else if screenHeight > 600 {
            height = height - 28
            ycoord = ycoord + 10
        } else {
            height = height - 10
            width = width + 20
            xcoord = xcoord - 10
        }
        
        
        
        let view = UIView(frame: CGRect(x: xcoord, y: ycoord, width: width, height: height))
        
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        return view
    }()
    
    let titleLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontSize: CGFloat = 25
        if screenH > 850 {
            fontSize = 35
        } else if screenH > 800 {
            fontSize = 32
        } else if screenH > 700 {
            fontSize = 33
        } else if screenH > 600 {
            fontSize = 32
        } else {
            fontSize = 28
        }
        label.text = "Equipment"
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let rsCheckbox: UISwitch = {
        
        let checker = UISwitch()
        checker.isOn = false
        checker.translatesAutoresizingMaskIntoConstraints = false
        return checker
    }()
    
    let aptCheckbox: UISwitch = {
        let checker = UISwitch()
        checker.isOn = false
        checker.translatesAutoresizingMaskIntoConstraints = false
        return checker
    }()
    
    let fnCheckbox: UISwitch = {
        let checker = UISwitch()
        checker.isOn = false
        checker.translatesAutoresizingMaskIntoConstraints = false
        return checker
    }()
    
    let rsLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontS: CGFloat = 20
        if screenH > 850 {
            fontS = 24
        } else if screenH > 700 {
            fontS = 22
        } else {
            fontS = 20
        }
        label.text = "Resistance Band"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: fontS)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    let aptLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontS: CGFloat = 20
        if screenH > 850 {
            fontS = 24
        } else if screenH > 700 {
            fontS = 22
        } else {
            fontS = 20
        }
        label.text = "Pull-Up Bar"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: fontS)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let fnLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontS: CGFloat = 20
        if screenH > 850 {
            fontS = 24
        } else if screenH > 700 {
            fontS = 22
        } else {
            fontS = 20
        }
        label.text = "Broomstick (or similar)"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: fontS)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private var finalTime: Int = 0
    private func findMaxTime() -> Int {
        
        
        finalTime = 0
        var generatedWithoutEquipment: [ExerciseObject] = []
        var generatedArray: [ExerciseObject] = []
        
        let aptBool = defaults.bool(forKey: "AnteriorPelvicTilt")
        let rsBool = defaults.bool(forKey: "RoundedShoulders")
        let fnBool = defaults.bool(forKey: "ForwardNeck")
        
        
        if aptBool {
            let apt = useSparinglyGenerateControllerGlobal.allAPT()
            for element in apt {
                if !generatedArray.contains(element) {
                    generatedArray.append(element)
                }
            }
            
        }
        if rsBool {
            let rs = useSparinglyGenerateControllerGlobal.allRS()
            for element in rs {
                if !generatedArray.contains(element) {
                    generatedArray.append(element)
                }
            }
        }
        if fnBool {
            let fn = useSparinglyGenerateControllerGlobal.allFN()
            for element in fn {
                if !generatedArray.contains(element) {
                    generatedArray.append(element)
                }
            }
        }
        
        
        if defaults.bool(forKey: "ResistanceBand") {
            if generatedArray.count > 0 {
            for x in 0...generatedArray.count - 1 {
                if generatedArray[x].resistanceBand {
                    if !generatedWithoutEquipment.contains(generatedArray[x]) {
                        generatedWithoutEquipment.append(generatedArray[x])
                    }
                }
            }
        }
        }
        
        if defaults.bool(forKey: "Pullup") {
            if generatedArray.count > 0 {
            for x in 0...generatedArray.count - 1 {
                if generatedArray[x].pullUp {
                    if !generatedWithoutEquipment.contains(generatedArray[x]) {
                        generatedWithoutEquipment.append(generatedArray[x])
                    }
                }
            }
        }
        }
        
        if defaults.bool(forKey: "Broomstick") {
            if generatedArray.count > 0 {
            for x in 0...generatedArray.count - 1 {
                if generatedArray[x].broomstick {
                    if !generatedWithoutEquipment.contains(generatedArray[x]) {
                        generatedWithoutEquipment.append(generatedArray[x])
                    }
                }
            }
            }
        }
        
        for element in generatedArray {
            if element.noEquipment {
                if !generatedWithoutEquipment.contains(element) {
                    generatedWithoutEquipment.append(element)
                }
            }
        }
        
        
        
        for element in generatedWithoutEquipment {
            finalTime = Int(element.duration) + finalTime
        }
        
       
        
        return finalTime
    }
    
    @objc func saveChanges() {
        
        
        
        defaults.set(rsCheckbox.isOn, forKey: "ResistanceBand")
        defaults.set(aptCheckbox.isOn, forKey: "Pullup")
        defaults.set(fnCheckbox.isOn, forKey: "Broomstick")
        
        let theFinalTime = findMaxTime() / 60
        defaults.set(theFinalTime, forKey: "TimeLimit")
        globalSettingsIsLaunched = false

        dismiss(animated: true)
    }
    
    let cancelButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1), for: .normal)
        button.backgroundColor = UIColor.white
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        button.layer.cornerRadius = 14
        
        return button
    }()
    
    @objc func dismissPopUp() {
        
        fnCheckbox.setOn(defaults.bool(forKey: "Broomstick"), animated: false)
        rsCheckbox.setOn(defaults.bool(forKey: "ResistanceBand"), animated: false)
        aptCheckbox.setOn(defaults.bool(forKey: "Pullup"), animated: false)

        globalSettingsIsLaunched = false
        dismiss(animated: true)
    }
    
}
