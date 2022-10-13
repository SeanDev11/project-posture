//
//  TrackBarCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 15.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import Macaw

class TrackBarCell: BaseCell {
    
    
    override func setupViews() {
        super.setupViews()
        
        
        
        let screenH = UIScreen.main.bounds.height
        
        
        var bottomConstant: CGFloat = -30
        if screenH > 800 {
            bottomConstant = -30
        } else if screenH > 700 {
            bottomConstant = -8
        } else if screenH > 600 {
            bottomConstant = -4
        } else {
            bottomConstant = -3
        }
        
        addSubview(totalWorkoutsText)
        totalWorkoutsText.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        totalWorkoutsText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant).isActive = true
        
        addSubview(totalWorkoutsNumber)
        if screenH > 850 {
            totalWorkoutsNumber.bottomAnchor.constraint(equalTo: totalWorkoutsText.bottomAnchor, constant: 6).isActive = true
        } else {
        totalWorkoutsNumber.centerYAnchor.constraint(equalTo: totalWorkoutsText.centerYAnchor).isActive = true
        }
        
        totalWorkoutsNumber.leftAnchor.constraint(equalTo: totalWorkoutsText.rightAnchor, constant: 8).isActive = true
        
        addSubview(totalMinutesNumber)
        totalMinutesNumber.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        totalMinutesNumber.centerYAnchor.constraint(equalTo: totalWorkoutsNumber.centerYAnchor).isActive = true
        
        addSubview(totalMinutesText)
        totalMinutesText.rightAnchor.constraint(equalTo: totalMinutesNumber.leftAnchor, constant: -8).isActive = true
        totalMinutesText.centerYAnchor.constraint(equalTo: totalWorkoutsText.centerYAnchor).isActive = true
        
        var seperatorConstant: CGFloat = -24
        if screenH > 800 {
            seperatorConstant = -24
        } else if screenH > 600 {
            seperatorConstant = -8
        } else {
            seperatorConstant = -6
        }
        
        addSubview(seperatorView)
        seperatorView.leftAnchor.constraint(equalTo: leftAnchor,constant: 15).isActive = true
        seperatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: totalMinutesText.topAnchor,constant: seperatorConstant).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        var averageMinutesConstant: CGFloat = -48
        if screenH > 800 {
            averageMinutesConstant = -48
        } else if screenH > 600 {
            averageMinutesConstant = -16
        } else {
            averageMinutesConstant = -14
        }
        
        addSubview(averageMinutesText)
        averageMinutesText.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        averageMinutesText.bottomAnchor.constraint(equalTo: totalWorkoutsText.topAnchor, constant: averageMinutesConstant).isActive = true
        
        addSubview(averageMinutesNumber)
        averageMinutesNumber.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        averageMinutesNumber.centerYAnchor.constraint(equalTo: averageMinutesText.centerYAnchor).isActive = true
        
        addSubview(seperatorViewTwo)
        seperatorViewTwo.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        seperatorViewTwo.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        seperatorViewTwo.bottomAnchor.constraint(equalTo: averageMinutesText.topAnchor,constant: -4).isActive = true
        seperatorViewTwo.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
        
        var barHeightConstant: CGFloat = 130
        var titleConstant: CGFloat = 0
        var barGraphConstant: CGFloat = -24
        if screenH > 850 {
            barGraphConstant = -24
            titleConstant = 0
            barHeightConstant = 130
        } else if screenH > 800 {
            barGraphConstant = -15
            titleConstant = 0
            barHeightConstant = 130
        } else if screenH > 700 {
            barGraphConstant = -4
            titleConstant = 0
            barHeightConstant = 130
        } else {
            barGraphConstant = 0
            titleConstant = 2
            barHeightConstant = 118
        }
        
        addSubview(barGraph)
       barGraph.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        barGraph.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30).isActive = true
        barGraph.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - barHeightConstant).isActive = true
        barGraph.bottomAnchor.constraint(equalTo: averageMinutesText.topAnchor, constant: barGraphConstant).isActive = true
       
        
       

        addSubview(graphTitle)
        graphTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        graphTitle.bottomAnchor.constraint(equalTo: barGraph.topAnchor, constant: titleConstant).isActive = true
        
        
        var streakTopConstant: CGFloat = 8
        if screenH > 800 {
            streakTopConstant = 8
        } else if screenH > 700 {
            streakTopConstant = 5
        } else if screenH > 600 {
            streakTopConstant = 4
        } else {
            streakTopConstant = 2
        }
        
        addSubview(workoutStreakLabel)
        workoutStreakLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        workoutStreakLabel.topAnchor.constraint(equalTo: topAnchor, constant: streakTopConstant).isActive = true
        
        
        
        
        delayAnimation()
        
        setupStreakCircles()
        

    }
    
    
//    var allWeeks = [WeeklyProgress]()
    
    var isLoaded = 0

    var theDelayTimer = Timer()
    

    
    func delayAnimation() {

        
        if isLoaded > 0 {
            MacawBarGraph.updateValues()
        barGraph.node = MacawBarGraph.createChart()
        }
      theDelayTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(animateGraphHere), userInfo: nil, repeats: false)

    }
    
    @objc func animateGraphHere() {
        

        isLoaded = isLoaded + 1
        MacawBarGraph.playAnimations()
        
        trackControllerFirstLaunch = false
    }
    
    
    
    let totalWorkoutsText: UILabel = {
        let screenHeightH = UIScreen.main.bounds.height

        let label = UILabel()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "Total\nWorkouts"
//        label.font = UIFont.systemFont(ofSize: 25)
        if screenHeightH > 850 {
        label.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.light)
        }
        else  if screenHeightH > 600 {
            label.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.light)
        } else {
            label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        }
        return label
    }()
    
    let totalWorkoutsNumber: UILabel = {
        let screenHeightH = UIScreen.main.bounds.height
        let label = UILabel()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
//        ADJUST FONT SIZE BASED ON NUMBER
        label.text = "\(defaults.integer(forKey: "TotalWorkouts"))"
        if screenHeightH > 850 {
        label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.ultraLight)
        } else if screenHeightH > 600 {
            label.font = UIFont.systemFont(ofSize: 45, weight: UIFont.Weight.ultraLight)
        } else {
            label.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.ultraLight)
        }
        return label
    }()
    
    let totalMinutesText: UILabel = {
        let screenHeightH = UIScreen.main.bounds.height

        let label = UILabel()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "Total\nMinutes"
        //        label.font = UIFont.systemFont(ofSize: 25)
        if screenHeightH > 850 {
        label.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.light)
        } else if screenHeightH > 600 {
            label.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.light)
        }  else {
            label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        }
        
        return label
    }()
    
    let totalMinutesNumber: UILabel = {
        let screenHeightH = UIScreen.main.bounds.height

        let label = UILabel()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(defaults.integer(forKey: "TotalTime"))"
//        ADJUST FONT SIZE BASED ON NUMBER
        if screenHeightH > 850 {
        label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.ultraLight)
        } else if screenHeightH > 600 {
            label.font = UIFont.systemFont(ofSize: 45, weight: UIFont.Weight.ultraLight)
        } else {
            label.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.ultraLight)
        }
        return label
    }()
    
    let averageMinutesText: UILabel = {
        let screenHeightH = UIScreen.main.bounds.height
        let label = UILabel()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "Average minutes\nspent per week"
        if screenHeightH > 700 {
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        } else  if screenHeightH > 600 {
            label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.light)
        } else {
            label.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.light)
        }
        return label
    }()
    
    let averageMinutesNumber: UILabel = {
        let screenHeightH = UIScreen.main.bounds.height

        let label = UILabel()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(defaults.integer(forKey: "TotalTime") / MacawBarGraph.lastFiveShows.count)"
        
        //        ADJUST FONT SIZE BASED ON NUMBER
        if screenHeightH > 700 {
        label.font = UIFont.systemFont(ofSize: 62, weight: UIFont.Weight.ultraLight)
        } else  if screenHeightH > 600 {
            label.font = UIFont.systemFont(ofSize: 58, weight: UIFont.Weight.ultraLight)
        } else {
            label.font = UIFont.systemFont(ofSize: 53, weight: UIFont.Weight.ultraLight)
        }
        
        return label
    }()
   
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
                view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seperatorViewTwo: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var barGraph: MacawBarGraph = {
        
        let bar = MacawBarGraph(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bar.contentMode = .scaleAspectFit
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = .clear
        
        
        return bar
    }()
    
    let graphTitle: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Weekly Minutes"
        label.translatesAutoresizingMaskIntoConstraints = false
        if screenH > 850 {
            label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        } else if screenH > 600 {
            label.font = UIFont.systemFont(ofSize: 27, weight: UIFont.Weight.light)
        } else {
            label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        }
        label.textColor = UIColor.gray
        return label
    }()
    
    let workoutStreakLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Workout Streak"
        label.translatesAutoresizingMaskIntoConstraints = false
        if screenH > 850 {
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        } else if screenH > 600 {
            label.font = UIFont.systemFont(ofSize: 27, weight: UIFont.Weight.light)
        } else {
            label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        }
        label.textColor = UIColor.gray
        
       return label
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    let circleHousing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    
    var firstCircle: UIView = UIView()
    var secondCircle: UIView = UIView()
    var thirdCircle: UIView = UIView()
    var fourthCircle: UIView = UIView()
    var fifthCircle: UIView = UIView()
    var sixthCircle: UIView = UIView()
    var seventhCircle: UIView = UIView()
    
    
    
    let shapeLayer = CAShapeLayer()
    let shapeLayers = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer() ,CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
    
//    let completions = defaults.array(forKey: "StreakArray")
    
    private func makeCircularProgressIndicator(radius: CGFloat, strokeWidth: CGFloat, layerIndex: Int) -> UIView {
        
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: (2 * radius), height: (2 * radius)))
        
        let center = circleView.center
        
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        trackLayer.lineWidth = strokeWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayers[layerIndex].path = circularPath.cgPath
        shapeLayers[layerIndex].strokeColor = UIColor.green.cgColor
        shapeLayers[layerIndex].lineWidth = strokeWidth
        shapeLayers[layerIndex].fillColor = UIColor.clear.cgColor
        shapeLayers[layerIndex].lineCap = CAShapeLayerLineCap.round
        shapeLayers[layerIndex].strokeEnd = 0
        
        circleView.layer.addSublayer(trackLayer)
        circleView.layer.addSublayer(shapeLayers[layerIndex])
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        circleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return circleView
    }
    
    func animateCircle(circleIndex: Int) {
        
        let completions = defaults.array(forKey: "StreakArray")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        if let theValue = completions?[circleIndex] {

            basicAnimation.toValue =  theValue
        }
        
        
        
        basicAnimation.duration = 1.0
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayers[circleIndex].add(basicAnimation, forKey: "basic")
        
        UIView.animate(withDuration: 1.3) {
            
            
        }
    }
    
    
    let circleRadius: CGFloat = {
        let heightScreen = UIScreen.main.bounds.height
        var radius: CGFloat = 22
        
        if heightScreen > 850 {
            radius = 24.5
        } else if heightScreen > 800 {
            radius = 22.5
        } else if heightScreen > 700 {
            radius = 25
        } else if heightScreen > 600 {
            radius = 22.5
        } else {
            radius = 18
        }
        
        
        return radius
    }()
    
    
    private func setupStreakCircles() {
        let screenH = UIScreen.main.bounds.height
        var spacingConstant: CGFloat = 2*(circleRadius) + 16
        
        var circleHousingTop: CGFloat = 12
        
        var firstCirceLeft: CGFloat = 12
        if screenH > 850 {
            firstCirceLeft = 6
            spacingConstant = 2*(circleRadius) + 16
            circleHousingTop = 12
        } else if screenH > 800 {
            firstCirceLeft = 4
            spacingConstant = 2*(circleRadius) + 15
            circleHousingTop = 8
        } else if screenH > 700 {
            firstCirceLeft = 4
            spacingConstant = 2*(circleRadius) + 16
            circleHousingTop = 12
        } else if screenH > 600 {
            firstCirceLeft = 4
            spacingConstant = 2*(circleRadius) + 14
            circleHousingTop = 6
        } else {
            firstCirceLeft = 4
            spacingConstant = 2*(circleRadius) + 14.3
            circleHousingTop = 0
        }
        
        
        
        addSubview(circleHousing)
        circleHousing.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        circleHousing.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
        circleHousing.topAnchor.constraint(equalTo: workoutStreakLabel.bottomAnchor,constant: circleHousingTop).isActive = true
        
        circleHousing.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        firstCircle = makeCircularProgressIndicator(radius: circleRadius, strokeWidth: 2, layerIndex: 0)
        firstCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(firstCircle)
        firstCircle.leftAnchor.constraint(equalTo: circleHousing.leftAnchor, constant: firstCirceLeft).isActive = true
        firstCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -(circleRadius)).isActive = true
        
        
        secondCircle = makeCircularProgressIndicator(radius: circleRadius, strokeWidth: 2, layerIndex: 1)
        secondCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(secondCircle)
        secondCircle.leftAnchor.constraint(equalTo: firstCircle.rightAnchor, constant: spacingConstant).isActive = true
        secondCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -(circleRadius)).isActive = true
        
        
        thirdCircle = makeCircularProgressIndicator(radius: circleRadius, strokeWidth: 2, layerIndex: 2)
        thirdCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(thirdCircle)
        thirdCircle.leftAnchor.constraint(equalTo: secondCircle.rightAnchor, constant: spacingConstant).isActive = true
        thirdCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -(circleRadius)).isActive = true
        
        
        fourthCircle = makeCircularProgressIndicator(radius: circleRadius, strokeWidth: 2, layerIndex: 3)
        fourthCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(fourthCircle)
        fourthCircle.leftAnchor.constraint(equalTo: thirdCircle.rightAnchor, constant: spacingConstant).isActive = true
        fourthCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -(circleRadius)).isActive = true
        
        
        fifthCircle = makeCircularProgressIndicator(radius: circleRadius, strokeWidth: 2, layerIndex: 4)
        fifthCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(fifthCircle)
        fifthCircle.leftAnchor.constraint(equalTo: fourthCircle.rightAnchor, constant: spacingConstant).isActive = true
        fifthCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -(circleRadius)).isActive = true
        
        
        sixthCircle = makeCircularProgressIndicator(radius: circleRadius, strokeWidth: 2, layerIndex: 5)
        sixthCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(sixthCircle)
        sixthCircle.leftAnchor.constraint(equalTo: fifthCircle.rightAnchor, constant: spacingConstant).isActive = true
        sixthCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -(circleRadius)).isActive = true
        
       animateAllCircles()

    }

    func animateAllCircles() {
        
        animateCircle(circleIndex: 0)
        
        animateCircle(circleIndex: 1)
        
        animateCircle(circleIndex: 2)
        
        animateCircle(circleIndex: 3)
        
        animateCircle(circleIndex: 4)
        
        animateCircle(circleIndex: 5)
        
    }
    
    
}
