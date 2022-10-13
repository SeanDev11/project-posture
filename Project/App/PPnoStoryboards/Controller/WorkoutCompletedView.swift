//
//  WorkoutCompletedView.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 07.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit


class WorkoutCompletedView: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let rootVC = navigationController?.viewControllers.first {
//            navigationController?.viewControllers = [rootVC, self]
//        }
        
        view.backgroundColor = UIColor.white
        
        
        
        
        setupViews()
        
        
        
        setupNavBar()
        
    }
    
    func setupNavBar() {
        
        let titleLabel = UILabel()
        titleLabel.text = "P|P"
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        titleLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        navigationItem.titleView = titleLabel
        
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem?.isEnabled = false
        
    }
    
    
    
    func setupViews() {
        
        if UIScreen.main.bounds.height > 800 {
            
            setupViewsBig()
            
        } else {
            setupViewsSmall()
        }
        
        
    }
    
    
    func setupViewsBig() {
        let screenH = UIScreen.main.bounds.height
        view.addSubview(congratulationsLabel)
        congratulationsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        var topConstant: CGFloat = 15
        if screenH > 850 {
            topConstant = 20
        } else {
            topConstant = 15
        }
        congratulationsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive = true
        
        view.addSubview(seperatorView)
        seperatorView.topAnchor.constraint(equalTo: congratulationsLabel.bottomAnchor, constant: topConstant).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        workoutTime.text = totalTimeLabelText()
        
        view.addSubview(totalTimeLabel)
        totalTimeLabel.text = "Workout Time: \(workoutTime.text ?? "00:00")"
        totalTimeLabel.textAlignment = .center
        totalTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        totalTimeLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: topConstant).isActive = true
        
        makeAndAddCircleBig()
        
        var areasLabel: CGFloat = 0
        if screenH > 850 {
            areasLabel = 10
        } else {
            areasLabel = 0
        }
        
        
        view.addSubview(areasImprovedLabel)
        areasImprovedLabel.topAnchor.constraint(equalTo: circularProgressView.topAnchor, constant: 2*(radiusCircularProgress) + topConstant + 7 + areasLabel).isActive = true
        areasImprovedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        
        let improvedAreasArray = getTargetAreas(workout: currentWorkoutArray)
        var improvedAreasText = ""
        for x in improvedAreasArray {
            improvedAreasText.append(x)
            improvedAreasText.append("\n")
        }
        improvedTextLabel.text = improvedAreasText
        
        view.addSubview(improvedTextLabel)
        improvedTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        var improvedConstant: CGFloat = 12
        var lineHeight: CGFloat = 40
        if screenH > 850 {
            improvedConstant = 20
            lineHeight = 45
            } else {
            improvedConstant = 12
            lineHeight = 40
        }
        
        
        improvedTextLabel.topAnchor.constraint(equalTo: areasImprovedLabel.bottomAnchor, constant: improvedConstant).isActive = true
        
        
        
        improvedTextLabel.lineHeight = lineHeight
        improvedTextLabel.textAlignment = .right
        
        
        
        let screenHeight = UIScreen.main.bounds.height
        view.addSubview(exitButton)
        exitButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (2 / 7)).isActive = true
        
        if screenHeight > 800 {
            view.addConstraintsWithFormat(format: "V:[v0(43)]-80-|", views: exitButton)
        } else if screenHeight > 600 {
            view.addConstraintsWithFormat(format: "V:[v0(38)]-49-|", views: exitButton)
        } else {
            view.addConstraintsWithFormat(format: "V:[v0(30)]-49-|", views: exitButton)
        }
        
        view.addSubview(verticalSeperator)
        verticalSeperator.heightAnchor.constraint(equalTo: exitButton.heightAnchor).isActive = true
        verticalSeperator.rightAnchor.constraint(equalTo: exitButton.leftAnchor).isActive = true
        verticalSeperator.widthAnchor.constraint(equalToConstant: 4).isActive = true
        verticalSeperator.bottomAnchor.constraint(equalTo: exitButton.bottomAnchor).isActive = true
        
        view.addSubview(saveFavoriteButton)
        saveFavoriteButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        saveFavoriteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (5 / 7) - 4).isActive = true
        
        if screenHeight > 800 {
            view.addConstraintsWithFormat(format: "V:[v0(43)]-80-|", views: saveFavoriteButton)
        } else if screenHeight > 600 {
            view.addConstraintsWithFormat(format: "V:[v0(38)]-49-|", views: saveFavoriteButton)
        } else {
            view.addConstraintsWithFormat(format: "V:[v0(30)]-49-|", views: saveFavoriteButton)
        }
        
        
    }
    
    
    
    
    
    
    
    func setupViewsSmall() {
        let screenHeight = UIScreen.main.bounds.height
        
        view.addSubview(congratulationsLabel)
        congratulationsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if screenHeight > 600 {
        congratulationsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        } else {
            congratulationsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        }
        view.addSubview(seperatorView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        seperatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        if screenHeight > 600 {
            seperatorView.topAnchor.constraint(equalTo: congratulationsLabel.bottomAnchor,constant: 25).isActive = true
        } else {
            seperatorView.topAnchor.constraint(equalTo: congratulationsLabel.bottomAnchor,constant: 15).isActive = true
        }
        
        workoutTime.text = totalTimeLabelText()
        
        
        view.addSubview(exitButton)
        exitButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (2 / 7)).isActive = true
        
        if screenHeight > 800 {
            view.addConstraintsWithFormat(format: "V:[v0(43)]-80-|", views: exitButton)
        } else if screenHeight > 600 {
            view.addConstraintsWithFormat(format: "V:[v0(38)]-49-|", views: exitButton)
        } else {
            view.addConstraintsWithFormat(format: "V:[v0(30)]-49-|", views: exitButton)
        }
        
        view.addSubview(verticalSeperator)
        verticalSeperator.heightAnchor.constraint(equalTo: exitButton.heightAnchor).isActive = true
        verticalSeperator.rightAnchor.constraint(equalTo: exitButton.leftAnchor).isActive = true
        verticalSeperator.widthAnchor.constraint(equalToConstant: 4).isActive = true
        verticalSeperator.bottomAnchor.constraint(equalTo: exitButton.bottomAnchor).isActive = true
        
        view.addSubview(saveFavoriteButton)
        saveFavoriteButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        saveFavoriteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (5 / 7) - 4).isActive = true
        
        if screenHeight > 800 {
            view.addConstraintsWithFormat(format: "V:[v0(43)]-80-|", views: saveFavoriteButton)
        } else if screenHeight > 600 {
            view.addConstraintsWithFormat(format: "V:[v0(38)]-49-|", views: saveFavoriteButton)
        } else {
            view.addConstraintsWithFormat(format: "V:[v0(30)]-49-|", views: saveFavoriteButton)
        }
        
        
        
        
        view.addSubview(totalTimeLabel)
        totalTimeLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 35).isActive = true
        totalTimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        view.addSubview(workoutTime)
        workoutTime.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor, constant: 10).isActive = true
        workoutTime.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -15).isActive = true
        
        
        

        makeAndAddCircle()
        
        var areasImprovedTopConstant: CGFloat = 10
        var labelTopConstant: CGFloat = 6

        if screenHeight > 800 {
            areasImprovedTopConstant = 10
            labelTopConstant = 6
        } else if screenHeight > 700 {
            areasImprovedTopConstant = 25
            labelTopConstant = 15
        } else if screenHeight > 600 {
            areasImprovedTopConstant = 20
            labelTopConstant = 10
        } else {
            areasImprovedTopConstant = 15
            labelTopConstant = 10
        }
        
        view.addSubview(areasImprovedLabel)
        areasImprovedLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        areasImprovedLabel.topAnchor.constraint(equalTo: seperatorViewTwo.bottomAnchor, constant: areasImprovedTopConstant).isActive = true
        

        let improvedAreasArray = getTargetAreas(workout: currentWorkoutArray)
        var improvedAreasText = ""
        for x in improvedAreasArray {
            improvedAreasText.append(x)
            improvedAreasText.append("\n")
        }
        
 
        improvedTextLabel.text = improvedAreasText
        view.addSubview(improvedTextLabel)
        
    
        
        improvedTextLabel.topAnchor.constraint(equalTo: areasImprovedLabel.bottomAnchor, constant: labelTopConstant).isActive = true
        improvedTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        if screenHeight > 600 {
        improvedTextLabel.lineHeight = 40
        } else {
            improvedTextLabel.lineHeight = 31
        }
        improvedTextLabel.textAlignment = .right
    }
    
    
    
    
    private func makeAndAddCircleBig() {
        
        let screenH = UIScreen.main.bounds.height
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        circularProgressView = makeCircularProgressIndicator(radius: radiusCircularProgress, strokeWidth: strokeCircularProgress)
        
        var circleSpaceConstant: CGFloat = 25
        if screenH > 850 {
            circleSpaceConstant = 35
        } else {
            circleSpaceConstant = 25
        }
        
        view.addSubview(circularProgressView)
        circularProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -(radiusCircularProgress)).isActive = true
        circularProgressView.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor, constant: circleSpaceConstant).isActive = true

        
//        view.addSubview(seperatorViewTwo)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorViewTwo)
//        seperatorViewTwo.topAnchor.constraint(equalTo: circularProgressView.topAnchor, constant: 2*(radiusCircularProgress) + 30).isActive = true
//        seperatorViewTwo.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        circularProgressView.addSubview(percentageLabel)
        percentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        percentageLabel.centerYAnchor.constraint(equalTo: circularProgressView.centerYAnchor, constant: radiusCircularProgress).isActive = true
        
        animateCircle()
        
        
        
    }
    
    
    
    
    
    
    
    private func makeAndAddCircle() {
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        circularProgressView = makeCircularProgressIndicator(radius: radiusCircularProgress, strokeWidth: strokeCircularProgress)
        
        view.addSubview(circularProgressView)
        circularProgressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        circularProgressView.topAnchor.constraint(equalTo: totalTimeLabel.topAnchor).isActive = true
        
        view.addSubview(seperatorViewTwo)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorViewTwo)
        seperatorViewTwo.topAnchor.constraint(equalTo: circularProgressView.topAnchor, constant: 2*(radiusCircularProgress) + 30).isActive = true
        seperatorViewTwo.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        circularProgressView.addSubview(percentageLabel)
        percentageLabel.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: radiusCircularProgress + 20).isActive = true
        percentageLabel.centerYAnchor.constraint(equalTo: circularProgressView.centerYAnchor, constant: radiusCircularProgress).isActive = true
        
        animateCircle()
    }
    
    
    private func convertToString(workout: [ExerciseObject]) -> [NSString] {
        var finalArray: [NSString] = []
        
        for x in workout {
            
            finalArray.append(x.name as NSString)
        }
        
        
        
        return finalArray
    }
    
    private func getTargetAreas(workout: [ExerciseObject]) -> [String] {
        
        var finalArray: [String] = []
        var apt = false
        var fw = false
        var rs = false
        
        
        for x in 0...(workout.count - 1) {
            
            if workout[x].anteriorPelvicTilt {
                apt = true
            }
            if workout[x].forwardNeck {
                fw = true
            }
            if workout[x].roundedShoulders {
                rs = true
            }
            
        }
        let first = "Forward Neck"
        let second = "Anterior Pelvic Tilt"
        let third = "Rounded Shoulders"
        
        if fw {
            finalArray.append(first)
        }
        if apt {
            finalArray.append(second)
        }
        if rs {
            finalArray.append(third)
        }
        
        
        return finalArray
    }
    
    
    
    let exitButton: UIButton = {
        let screenHeight = UIScreen.main.bounds.height
        let btn = UIButton()
        btn.setTitle("Exit", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        
        if screenHeight > 800 {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            
        } else if screenHeight > 600 {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
        } else {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(exitPressed), for: .touchUpInside)
       return btn
    }()
    
    var delayDelayTimer = Timer()
    
    @objc func exitPressed() {
        
        if tabBarController?.selectedIndex == 2 {
            tabBarController?.selectedIndex = 1
            
        }
        
        useSparinglyGenerateControllerGlobal.scrollToMenuIndex(menuIndex: 1)

        let totalTime: Int = Int(calcDuration(workout: currentWorkoutArray)) / 60
        let current = defaults.integer(forKey: "TotalTime")
        defaults.set(totalTime + current, forKey: "TotalTime")
        
        let currentWorkouts = defaults.integer(forKey: "TotalWorkouts")
        defaults.set(currentWorkouts + 1, forKey: "TotalWorkouts")
        
//        let indexPath = IndexPath(item: 1, section: 0)
//        useSparinglyGenerateControllerGlobal.collectionView.scrollToItem(at: indexPath, at: [], animated: false)
        
       navigationController?.popToRootViewController(animated: true)
        
        delayDelayTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(reloadDGView), userInfo: nil, repeats: false)

    }
    
    @objc func reloadDGView() {
        delayDelayTimer.invalidate()
        useSparinglyGenerateControllerGlobal.reloadDailyGoalView()

    }
    
    
    let saveFavoriteButton: UIButton = {
        let screenHeight = UIScreen.main.bounds.height
        let btn = UIButton()
        btn.setTitle("Save to Favorites", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        
        if screenHeight > 800 {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            
        } else if screenHeight > 600 {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
        } else {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(saveFavorite), for: .touchUpInside)
       return btn
    }()
    
  @objc private func saveFavorite() {
        
        let alert = UIAlertController(title: "Save Favorite", message: nil, preferredStyle: .alert)
    alert.addTextField { (textField) in
        textField.placeholder = "Favorite Name"
    }
    let action = UIAlertAction(title: "Save Favorite", style: .default) { (_) in
        
        let name = alert.textFields?.first?.text
//-----------------------------------------------
//        let wallSlidess = ExerciseObject(name: "Wall Slides", duration: 60, anteriorPelvicTilt: false, forwardNeck: true, roundedShoulders: true, noEquipment: true, physioBall: false, resistanceBand: false)
//        wallSlidess.videoLink = Bundle.main.path(forResource: "theVideo", ofType: "MOV")
//
//        let heelSquatss = ExerciseObject(name: "Heel Squat", duration: 30, anteriorPelvicTilt: true, forwardNeck: false, roundedShoulders: false, noEquipment: true, physioBall: false, resistanceBand: false)
//        heelSquatss.videoLink = ""
//        ---------------------------
        let favorite = Favorite(context: PersistenceService.contextReal)
        favorite.name = name
//        favorite.workoutArray = currentWorkoutArray
//        favorite.workoutArray = [wallSlidess, heelSquatss]
        favorite.duration = self.calcDuration(workout: currentWorkoutArray) / 60
        let targetAreas = self.getTargetAreas(workout: currentWorkoutArray)
        favorite.anteriorPelvicTilt = false
        favorite.forwardNeck = false
        favorite.roundedShoulders = false
        favorite.noEquipment = true
        favorite.pullUp = false
        favorite.resistanceBand = false
        
        favorite.workoutArray = self.convertToString(workout: currentWorkoutArray)
        
            for x in targetAreas {
                if x == "Anterior Pelvic Tilt" {
                    favorite.anteriorPelvicTilt = true
                }
                if x == "Rounded Shoulders" {
                    favorite.roundedShoulders = true
                }
                if x == "Forward Neck" {
                    favorite.forwardNeck = true
                }
            }
        
        PersistenceService.saveContext()
        self.exitPressed()
        
    }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
     func calcDuration(workout: [ExerciseObject]) -> Int16 {
        var total: Int16 = 0
        
        for x in 0...(workout.count - 1) {
           total = total + workout[x].duration
        }
        return total
    }
    
    private func totalTimeLabelText() -> String {
        
        let total = calcDuration(workout: currentWorkoutArray)
        
        let minutes = Int(total) / 60 % 60
        let secondsFormatted = Int(total) % 60
        
        return String(format: "%02i:%02i", minutes, secondsFormatted)
    }
    
    
    
    let congratulationsLabel: UILabel = {
        let screenHeight = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Congratulations!"
        if screenHeight > 850 {
            label.font = UIFont.systemFont(ofSize: 40)
        } else if screenHeight > 800 {
            label.font = UIFont.systemFont(ofSize: 35)
            
        } else if screenHeight > 600 {
            label.font = UIFont.systemFont(ofSize: 35)
            
        } else {
            label.font = UIFont.systemFont(ofSize: 30)
        }
        label.translatesAutoresizingMaskIntoConstraints = false

       return label
    }()
    
    let totalTimeLabel: UILabel = {
        let screenHeight = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Workout Time"
        if screenHeight > 850 {
            label.font = UIFont.systemFont(ofSize: 33)
            
        } else if screenHeight > 800 {
            label.font = UIFont.systemFont(ofSize: 30)
            
        } else if screenHeight > 600 {
            label.font = UIFont.systemFont(ofSize: 30)
            
        } else {
            label.font = UIFont.systemFont(ofSize: 25)
            
        }
        label.translatesAutoresizingMaskIntoConstraints = false

        
        return label
    }()
    
    let workoutTime: UILabel = {
        let screenHeight = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.black
        if screenHeight > 850 {
            label.font = UIFont.systemFont(ofSize: 33)
            
        } else if screenHeight > 800 {
            label.font = UIFont.systemFont(ofSize: 30)
            
        } else if screenHeight > 600 {
            label.font = UIFont.systemFont(ofSize: 30)
            
        } else {
            label.font = UIFont.systemFont(ofSize: 25)
            
        }
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
    
    
    let areasImprovedLabel: UILabel = {
        
        let screenHeight = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Areas Improved"
        if screenHeight > 850 {
            label.font = UIFont.systemFont(ofSize: 33)
            
        } else if screenHeight > 800 {
            label.font = UIFont.systemFont(ofSize: 30)
            
        } else if screenHeight > 600 {
            label.font = UIFont.systemFont(ofSize: 30)
            
        } else {
            label.font = UIFont.systemFont(ofSize: 25)
            
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let improvedTextLabel: UILabel = {
        let screenHeight = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = ""
        if screenHeight > 850 {
            label.font = UIFont.systemFont(ofSize: 30)
        } else if screenHeight > 800 {
            label.font = UIFont.systemFont(ofSize: 27)
        } else if screenHeight > 600 {
            label.font = UIFont.systemFont(ofSize: 27)
        } else {
            label.font = UIFont.systemFont(ofSize: 22)
        }
        
        label.numberOfLines = 4
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineHeight = 10
        return label
    }()
    
    let verticalSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
               view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        return view
    }()
    
    let seperatorViewTwo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        return view
    }()
    

    
    
    
    
    let radiusCircularProgress: CGFloat = {
        
        var radius = CGFloat(50)
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        if screenHeight > 800 {
            radius = 118
        } else if screenHeight > 700 {
            radius = 100
        } else if screenHeight > 600 {
            radius = 75
        } else {
            radius = 60
        }
        
        return radius
    }()
    
    let strokeCircularProgress: CGFloat = {
        
        var stroke = CGFloat(5)
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        if screenHeight > 800 {
            stroke = 8
        } else if screenHeight > 600 {
            stroke = 7
        } else {
            stroke = 6
        }
        
        return stroke
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        var fontSize: CGFloat = 30
        
        if UIScreen.main.bounds.height > 800  {
            fontSize = 70
        } else if UIScreen.main.bounds.height > 700 {
            fontSize = 55
        } else if UIScreen.main.bounds.height > 600 {
            fontSize = 48
        } else {
            fontSize = 30
        }
        
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.ultraLight)
        
        return label
    }()
    
    
    
    let shapeLayer = CAShapeLayer()
    var circularProgressView = UIView()
    
    
    private func makeCircularProgressIndicator(radius: CGFloat, strokeWidth: CGFloat) -> UIView {
        
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: (2 * radius), height: (2 * radius)))
        
        
        let center = circleView.center
        
        
        
        //        create track layer
        
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        trackLayer.lineWidth = strokeWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        
        
        
        
        
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = strokeWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        
        shapeLayer.strokeEnd = 0
        
        
        
        
        circleView.layer.addSublayer(trackLayer)
        circleView.layer.addSublayer(shapeLayer)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        circleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return circleView
        
        
        
        
    }
    
    var x = 0
    
    var timer : Timer?
    
    //        WAS minutesInvestedNumber

    lazy var percentage = Int(100 * (CGFloat(defaults.integer(forKey: "DailyProgress")) / CGFloat(defaults.integer(forKey: "DailyGoal"))))
    
    @objc func changePercentageText() {
        
        if x < percentage {
            percentageLabel.text = "\(x)%"
            x = x + 1
        } else if x == percentage {
            
            percentageLabel.text = "\(x)%"
            x = x + 1
            
            timer?.invalidate()
        }
        
        
    }
    
    
    
    fileprivate func animateCircle() {
        
        timer?.invalidate()
        
        x = 0
        
        
        //        WAS minutesInvestedNumber

        percentage = Int(100 * (CGFloat(defaults.integer(forKey: "DailyProgress")) / CGFloat(defaults.integer(forKey: "DailyGoal"))))
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        
//        WAS minutesInvestedNumber
        basicAnimation.toValue =  CGFloat(defaults.integer(forKey: "DailyProgress")) / CGFloat(defaults.integer(forKey: "DailyGoal"))
        basicAnimation.duration = 1.3
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basic")
        
        
        percentageLabel.alpha = 1.0
        
        
        let interval: TimeInterval = TimeInterval(1.3) / TimeInterval(percentage)
        timer =  Timer.scheduledTimer(timeInterval: interval, target: self, selector:#selector(self.changePercentageText), userInfo: nil, repeats: true)
        
        
        UIView.animate(withDuration: 1.3) {
            
            self.percentageLabel.alpha = 0.0
            
            self.percentageLabel.alpha = 1
            
        }
        
    }
    
    @objc func handleTap() {
        
        
        animateCircle()
        
        
    }
    
    
    
}
