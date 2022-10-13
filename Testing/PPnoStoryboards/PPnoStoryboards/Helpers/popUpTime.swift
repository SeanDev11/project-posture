//
//  popUpTime.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 23.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class popUpTime: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

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
        for x in 0...generatedArray.count - 1 {
            if generatedArray[x].resistanceBand {
                if !generatedWithoutEquipment.contains(generatedArray[x]) {
                generatedWithoutEquipment.append(generatedArray[x])
                }
            }
        }
    }
    
    if defaults.bool(forKey: "Pullup") {
        for x in 0...generatedArray.count - 1 {
            if generatedArray[x].pullUp {
                if !generatedWithoutEquipment.contains(generatedArray[x]) {
                generatedWithoutEquipment.append(generatedArray[x])
                }
            }
        }
    }
    
    if defaults.bool(forKey: "Broomstick") {
        for x in 0...generatedArray.count - 1 {
            if generatedArray[x].broomstick {
                if !generatedWithoutEquipment.contains(generatedArray[x]) {
                generatedWithoutEquipment.append(generatedArray[x])
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
    
   
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
        let numberOfComps = Int(finalTime / 60) - 3
        
        return numberOfComps
    }
    
   
//    ISSUE HERE
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerNumbers[row])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        finalTime = 0
        finalTime = findMaxTime()
        createPopUpTime()
        
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.87)
        
        view.isOpaque = false
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        fillArray()
        
        createPopUpTime()
        
       pickerView.selectRow(0, inComponent: 0, animated: false)
        
        finalTime = findMaxTime()

    }
    
    func createPopUpTime() {
        
        view.addSubview(popUp)
        
        
        popUp.addSubview(titleLabel)
        popUp.addSubview(pickerView)
        
        popUp.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        popUp.addConstraintsWithFormat(format: "V:|-15-[v0]", views: titleLabel )
        
        
        
        
        popUp.addConstraints([NSLayoutConstraint(item: pickerView, attribute: .centerY, relatedBy: .equal, toItem: popUp, attribute: .centerY, multiplier: 1, constant: 0)])
        popUp.addConstraintsWithFormat(format: "H:|[v0]|", views: pickerView)
        
        
        
        
        
        
        
        popUp.addSubview(checkButton)
        popUp.addSubview(cancelButton)
        
        
        
        
        
        
        popUp.addConstraintsWithFormat(format: "H:|-10-[v0]", views: checkButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: checkButton)
        
        popUp.addConstraintsWithFormat(format: "H:[v0]-10-|", views: cancelButton)
        popUp.addConstraintsWithFormat(format: "V:[v0]-15-|", views: cancelButton)
        
        
        
        popUp.addConstraint(NSLayoutConstraint(item: checkButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 2/3.3, constant: 0))
        popUp.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: popUp, attribute: .width, multiplier: 1/3.3, constant: 0))
        
        
    }
    
    var pickerNumbers: [Int] = [4,5,6]
    
    func fillArray() {
        
        for x in 7...14 {
            
            pickerNumbers.append(x)
            
        }
    }
    
    let popUp: UIView = {
        
        let xcoord = UIScreen.main.bounds.width / 9
        
        var ycoord = UIScreen.main.bounds.height / 6
        
        var width = UIScreen.main.bounds.width * (7 / 9)
        
        var height = UIScreen.main.bounds.height / 2
        if UIScreen.main.bounds.height > 800 {
            height = 667 / 2
            
            ycoord = ycoord + 60
            
        } else if UIScreen.main.bounds.height > 700 {
            height = height - 20
            width = width - 16
        } else {
            height = height - 15
            ycoord = ycoord + 10
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
            fontSize = 35
        } else if screenH > 700 {
            fontSize = 33
        } else if screenH > 600 {
            fontSize = 32
        } else {
            fontSize = 28
        }
        label.text = "Set Workout Time"
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
       return label
    }()
    
    
    let pickerView:UIPickerView = {
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
    
    @objc func saveChanges() {
        defaults.set(pickerView.selectedRow(inComponent: 0) + 4, forKey: "TimeLimit")
        
        globalSettingsIsLaunched = false

        dismiss(animated: true)
    }
    
    @objc func dismissPopUp() {
        
        
        pickerView.selectRow(0, inComponent: 0, animated: false)
        globalSettingsIsLaunched = false

        dismiss(animated: true)
        
    }
    
    
    
    
}
