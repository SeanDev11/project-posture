//
//  dailyGoalViewCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 07.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit
import Foundation


class dailyGoalViewCell: BaseCell {
    
    
    
    let dailyGoalView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let editButton: UIButton = {
        let screenH = UIScreen.main.bounds.height
        let btn = UIButton()
        btn.setTitle("edit", for: .normal)
        
        btn.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0.75), for: .normal)
        var fontSize: CGFloat = 14
        if screenH > 850 {
            fontSize = 30
        } else if screenH > 800 {
            fontSize = 27
        } else if screenH > 700 {
            fontSize = 24
        } else if screenH > 600 {
            fontSize = 20
        } else {
            fontSize = 17
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(GenerateController.editDailyGoal), for: .touchUpInside)
        return btn
    }()
    
    @objc func editDailyGoal() {
    
    
    }
    
    let minutesInvestedLabel: UILabel = {
        
        let label = UILabel()
        label.text = "TODAY"
        label.numberOfLines = 0
        var fontSize: CGFloat = 30
        
        if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
            fontSize = 52
        } else if UIScreen.main.bounds.height > 600 {
            fontSize = 45
        } else {
            fontSize = 30
        }
        
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir", size: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.font = UIFont(name: "GillSans-Light", size: 30)
        
        return label
    }()
    
    
    lazy var minutesLabel: UILabel = {
        
        let label = UILabel()
        label.text = "\(defaults.integer(forKey: "DailyProgress"))"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
//        label.backgroundColor = UIColor.green
        label.numberOfLines = 0
        
        var fontSize: CGFloat = 30
        
        if UIScreen.main.bounds.height > 850 {
            fontSize = 118
        } else if UIScreen.main.bounds.height > 800 {
            fontSize = 99
        } else if UIScreen.main.bounds.height > 700 {
            fontSize = 90
            
        } else if UIScreen.main.bounds.height > 600 {
            fontSize = 80
        } else {
            fontSize = 50
        }
        
      
//        label.font = UIFont(name: "Avenir", size: fontSize)
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.ultraLight)
//        label.font = UIFont(name: "Avenir-LightOblique", size: fontSize)
        return label
    }()
    
    
    
    let selectorCellHeight: CGFloat = {
        
        let screenHeight = UIScreen.main.bounds.height
        var height: CGFloat = 350
        if screenHeight > 850 {
            height = screenHeight / 7.5
        }
        if screenHeight > 800 {
            height = 667 / 6.6368
        } else {
            height = screenHeight / 6.6368
        }
        
        return height
    }()
    
    let radiusCircularProgress: CGFloat = {
        
        var radius = CGFloat(40)
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        if screenHeight > 850 {
            radius = 90
        } else if screenHeight > 800 || screenWidth > 400 {
            radius = 74
        } else if screenHeight > 600 {
            radius = 60
        } else {
            radius = 47
        }
        
        return radius
    }()
    
    let strokeCircularProgress: CGFloat = {
        
        var stroke = CGFloat(10)
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        if screenHeight > 850 {
            stroke = 8
        } else if screenHeight > 800 || screenWidth > 400 {
            stroke = 7
        } else if screenHeight > 600 {
            stroke = 6
        } else {
            stroke = 5
        }

        return stroke
    }()
    
    let percentageLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "0%"
        label.textAlignment = .center
        var fontSize: CGFloat = 30
        
        if screenH > 850 {
            fontSize = 55
        } else if screenH > 800 {
            fontSize = 50
        } else if screenH > 700 {
            fontSize = 50
        } else if screenH > 600 {
            fontSize = 40
        } else {
            fontSize = 28
        }
//        if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
//            fontSize = 45
//        } else if UIScreen.main.bounds.height > 600 {
//            fontSize = 40
//        } else {
//            fontSize = 27
//        }
        
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.ultraLight)
        
       return label
    }()
    
  
    

    
   
    
    let homeController = GenerateController()
    
   
    
    lazy var cellHeight: CGFloat = {
        
        var height: CGFloat = 0
        if UIScreen.main.bounds.height > 800 {
            
            height = UIScreen.main.bounds.height - (200 + 3*(self.selectorCellHeight) + homeController.navBarHeight)
            
        } else {
            
           height = UIScreen.main.bounds.height - (110 + 3*(self.selectorCellHeight) + homeController.navBarHeight + 40)
        }
        
        return height
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(dailyGoalView)
        let screenH = UIScreen.main.bounds.height
        dailyGoalView.addSubview(minutesInvestedLabel)
        dailyGoalView.addSubview(minutesLabel)
        

        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dailyGoalView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: dailyGoalView)
        

        
        
        circularProgressView = makeCircularProgressIndicator(radius: radiusCircularProgress, strokeWidth: strokeCircularProgress)
        
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
    
        
        dailyGoalView.addSubview(circularProgressView)
        
        dailyGoalView.addConstraintsWithFormat(format: "H:|-25-[v0]", views: circularProgressView)
        
        
        var moveCircleDown:CGFloat = 0
        if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
            moveCircleDown = 10
        } else if screenH > 600 {
            moveCircleDown = 0
        } else {
            moveCircleDown = 4
        }

        circularProgressView.centerYAnchor.constraint(equalTo: dailyGoalView.centerYAnchor, constant: -(radiusCircularProgress) + moveCircleDown).isActive = true
        
 
       dailyGoalView.addSubview(percentageLabel)
        dailyGoalView.addSubview(editButton)
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
      
   
        dailyGoalView.addConstraintsWithFormat(format: "H:|-25-[v0(\(2*radiusCircularProgress))]", views: percentageLabel)
        
        var percentageLabelUp: CGFloat = 8
        if screenH > 850 {
            percentageLabelUp = 8
        } else if screenH > 800 {
            percentageLabelUp = 6
        } else if screenH > 700 {
            percentageLabelUp = 4
        } else if screenH > 600 {
            percentageLabelUp = 2
        } else {
            percentageLabelUp = 4
        }

       percentageLabel.centerYAnchor.constraint(equalTo: dailyGoalView.centerYAnchor, constant: moveCircleDown - percentageLabelUp).isActive = true
        
        editButton.centerXAnchor.constraint(equalTo: percentageLabel.centerXAnchor).isActive = true
        
        var editButtonConstant: CGFloat = 8
        if screenH > 850 {
            editButtonConstant = 30
        } else if screenH > 800 {
            editButtonConstant = 32
        } else if screenH > 700 {
            editButtonConstant = 24
        } else if screenH > 600 {
            editButtonConstant = 16
        } else {
            editButtonConstant = 12
        }
        
        
        editButton.topAnchor.constraint(equalTo: dailyGoalView.centerYAnchor, constant: editButtonConstant).isActive = true
 
        var moveTodayUp: CGFloat = 10
        if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
            moveTodayUp = 15
        } else if UIScreen.main.bounds.height > 600 {
            moveTodayUp = 10
        } else {
            moveTodayUp = 7
        }
        
        var moveMinutesDown: CGFloat = 7
        if UIScreen.main.bounds.height > 850 {
            moveMinutesDown = -8
        } else if UIScreen.main.bounds.height > 800 || UIScreen.main.bounds.width > 400 {
            moveMinutesDown = 10
        } else if UIScreen.main.bounds.height > 600 {
            moveMinutesDown = 7
        } else {
            moveMinutesDown = 5
        }
        

        minutesInvestedLabel.topAnchor.constraint(equalTo: circularProgressView.topAnchor, constant: -(moveTodayUp)).isActive = true
        minutesInvestedLabel.rightAnchor.constraint(equalTo: dailyGoalView.rightAnchor, constant: -20).isActive = true
        
        minutesLabel.bottomAnchor.constraint(equalTo: circularProgressView.topAnchor, constant: 2*(radiusCircularProgress) + moveMinutesDown).isActive = true
        minutesLabel.rightAnchor.constraint(equalTo: minutesInvestedLabel.rightAnchor).isActive = true
        
        
        
        
//       REMOVE BEFORE FINISH
        dailyGoalView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        

        animateCircle()
        
    }
    
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
    
    
    
     func animateCircle() {
        
        timer?.invalidate()
        
        x = 0
        
         percentage = Int(100 * (CGFloat(defaults.integer(forKey: "DailyProgress")) / CGFloat(defaults.integer(forKey: "DailyGoal"))))
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        
        
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
