//
//  StreakTester.swift
//  BarChart
//
//  Created by Sean Devine on 15.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//


import UIKit
import Macaw

class StreakTester: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
    }
    
    
    var firstCircle: UIView = UIView()
    var secondCircle: UIView = UIView()
    var thirdCircle: UIView = UIView()
    var fourthCircle: UIView = UIView()
    var fifthCircle: UIView = UIView()
    var sixthCircle: UIView = UIView()
    var seventhCircle: UIView = UIView()
    
    
    
    func setupViews() {
        view.backgroundColor = UIColor.white
       
        view.addSubview(circleHousing)
        circleHousing.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        circleHousing.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        
        circleHousing.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        
        circleHousing.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        
         firstCircle = makeCircularProgressIndicator(radius: 22, strokeWidth: 2, layerIndex: 0)
        firstCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(firstCircle)
        firstCircle.leftAnchor.constraint(equalTo: circleHousing.leftAnchor, constant: 4).isActive = true
        firstCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -22).isActive = true
        
        
        secondCircle = makeCircularProgressIndicator(radius: 22, strokeWidth: 2, layerIndex: 1)
        secondCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(secondCircle)
        secondCircle.leftAnchor.constraint(equalTo: firstCircle.rightAnchor, constant: 60).isActive = true
        secondCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -22).isActive = true
        
        
        thirdCircle = makeCircularProgressIndicator(radius: 22, strokeWidth: 2, layerIndex: 2)
        thirdCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(thirdCircle)
        thirdCircle.leftAnchor.constraint(equalTo: secondCircle.rightAnchor, constant: 60).isActive = true
        thirdCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -22).isActive = true
        
        
        fourthCircle = makeCircularProgressIndicator(radius: 22, strokeWidth: 2, layerIndex: 3)
        fourthCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(fourthCircle)
        fourthCircle.leftAnchor.constraint(equalTo: thirdCircle.rightAnchor, constant: 60).isActive = true
        fourthCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -22).isActive = true
        
        
        fifthCircle = makeCircularProgressIndicator(radius: 22, strokeWidth: 2, layerIndex: 4)
        fifthCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(fifthCircle)
        fifthCircle.leftAnchor.constraint(equalTo: fourthCircle.rightAnchor, constant: 60).isActive = true
        fifthCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -22).isActive = true
        
        
        sixthCircle = makeCircularProgressIndicator(radius: 22, strokeWidth: 2, layerIndex: 5)
        sixthCircle.translatesAutoresizingMaskIntoConstraints = false
        
        circleHousing.addSubview(sixthCircle)
        sixthCircle.leftAnchor.constraint(equalTo: fifthCircle.rightAnchor, constant: 60).isActive = true
        sixthCircle.centerYAnchor.constraint(equalTo: circleHousing.centerYAnchor, constant: -22).isActive = true
        

        animateCircle(circleIndex: 0)
        
        animateCircle(circleIndex: 1)
        
        animateCircle(circleIndex: 2)
        
        animateCircle(circleIndex: 3)
        
        animateCircle(circleIndex: 4)
        
        animateCircle(circleIndex: 5)
        
    }
    
    let circleHousing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear

        return view
    }()
    

    let shapeLayer = CAShapeLayer()
    let shapeLayers = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer() ,CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
    
    let completions = [0.8, 1.0, 0.2, 0.0, 0.5, 0.9]
    
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
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue =  completions[circleIndex]
        basicAnimation.duration = 1.0
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayers[circleIndex].add(basicAnimation, forKey: "basic")
        
        UIView.animate(withDuration: 1.3) {
            
     
        }
    }
    

}




