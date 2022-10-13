//
//  VideoLauncher.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 13.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

var tempGlobalX = 0

class VideoPlayerView: UIView {

    var player: AVQueuePlayer?
    var playerLooper: AVPlayerLooper?
    var playerLayer: AVPlayerLayer!
    var theParent: VideoLauncher?
   var theItem: AVPlayerItem?
//    var theURL: URL
    
    @objc func dismissVideoLauncher() {
        
            player?.pause()
//            player = nil

    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        if isLaunched == false {
        setupPlayerView()
        }
        setupObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(playTheVideo), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playTheVideo), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseTheVideo), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseTheVideo), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc func playTheVideo() {
        player?.play()
    }
    
    @objc func pauseTheVideo() {
        player?.pause()
        
    }
    
    
    
     func setupPlayerView() {
        if let videoURL = currentWorkoutArray[currentExercise].videoLink {
            
            if player == nil {
            player = AVQueuePlayer()
            player?.isMuted = true
                
             playerLayer = AVPlayerLayer(player: player)
                self.layer.addSublayer(playerLayer)
                playerLayer.frame = self.frame
                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                }
            
            player?.removeAllItems()
           
            theItem = AVPlayerItem(url: URL(fileURLWithPath: videoURL))
            playerLooper = AVPlayerLooper(player: player!, templateItem: theItem!)

            player?.play()
          }

        }
    
    func setupPlayerViewCV(video: String?) {
        
        
        if let videoURL = video {
            if player == nil {
                player = AVQueuePlayer()
                player?.isMuted = true
                
                playerLayer = AVPlayerLayer(player: player)
                self.layer.addSublayer(playerLayer)
                playerLayer.frame = self.frame
                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            }
            
            player?.removeAllItems()
            
            theItem = AVPlayerItem(url: URL(fileURLWithPath: videoURL))
            playerLooper = AVPlayerLooper(player: player!, templateItem: theItem!)
            
            
            
            player?.play()
        }
        
    }
    
    @objc func dismissVideoViewFirst() {
        
        theParent?.closingAnimation()
        dismissVideoLauncher()
        
        
     
    }

    
   
    

    
    
}

class VideoLauncher: UIView   {
    
    
    
    let exerciseNameLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontS: CGFloat = 33
        if screenH > 850 {
            fontS = 40
        } else if screenH > 600 {
            fontS = 33
        } else {
            fontS = 28
        }
        label.text = "Exercise Name"
        label.font = UIFont.systemFont(ofSize: fontS)
        label.translatesAutoresizingMaskIntoConstraints = false
        
       return label
    }()
    
    let topTipsLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontS: CGFloat = 27
        if screenH > 850 {
            fontS = 35
        } else if screenH > 600 {
            fontS = 27
        } else {
            fontS = 25
        }
        label.text = "Top Tips"
        label.font = UIFont.systemFont(ofSize: fontS)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let targetAreasLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontS: CGFloat = 26
        label.text = "Target Areas"
        if screenH > 850 {
            fontS = 32
        } else if screenH > 600 {
            fontS = 26
        } else {
            fontS = 23
        }
        label.font = UIFont.systemFont(ofSize: fontS)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
       return label
    }()
    
    let equipmentLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        var fontS: CGFloat = 26
        if screenH > 850 {
            fontS = 32
        } else if screenH > 600 {
            fontS = 26
        } else {
            fontS = 23
        }
        label.text = "Equipment"
        label.font = UIFont.systemFont(ofSize: fontS)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        //        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func getTargetAreasVideoLauncher(exercise: ExerciseObject) -> [String] {
        
        var finalArray: [String] = []
        var apt = false
        var fw = false
        var rs = false
        
            if exercise.anteriorPelvicTilt {
                apt = true
            }
            if exercise.forwardNeck {
                fw = true
            }
            if exercise.roundedShoulders {
                rs = true
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
    
    private func getEquipmentVideoLauncher(exercise: ExerciseObject) -> [String] {
        
        var finalArray: [String] = []
        var res = false
        var phys = false
        var stick = false
        
        if exercise.resistanceBand {
            res = true
        }
        if exercise.pullUp {
            phys = true
        }
        if exercise.broomstick {
            stick = true
        }
        let first = "Resistance Band"
        let second = "Pull-Up Bar"
        let third = "Broomstick"
        if res {
            finalArray.append(first)
        }
        if phys {
            finalArray.append(second)
        }
        if stick {
            finalArray.append(third)
        }
        
        return finalArray
    }
    
    

    let topTipsLabelList: UILabel = {
        let screenH = UIScreen.main.bounds.height

        let field = UILabel()
        field.numberOfLines = 0
    field.text = "Contract shoulder blades back and down"
        field.translatesAutoresizingMaskIntoConstraints = false
        var fontS: CGFloat = 23
        if screenH > 850 {
            fontS = 28
        } else if screenH > 700 {
            fontS = 24.5
        } else if screenH > 600 {
            fontS = 23
        } else {
            fontS = 20
        }
        field.font = UIFont.systemFont(ofSize: fontS, weight: .light)
        return field
        
    }()
    
    let targetAreasLabelList: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.numberOfLines = 3
        var fontS: CGFloat = 20
        if screenH > 850 {
            fontS = 24
        } else if screenH > 700 {
            fontS = 22
        } else if screenH < 600 {
            fontS = 18
        }
        iv.font = UIFont.systemFont(ofSize: fontS)
       return iv
    }()
    
    let equipmentLabelList: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let iv = UILabel()
        
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        var fontS: CGFloat = 20
        if screenH > 850 {
            fontS = 24
        } else if screenH > 700 {
            fontS = 22
        } else if screenH < 600 {
            fontS = 18
        }
        iv.font = UIFont.systemFont(ofSize: fontS)
        return iv
    }()
    
    lazy var dimissVideoLauncherButton: UIButton = {
        let screenH = UIScreen.main.bounds.height
        let btn = UIButton()
        btn.setTitle("X", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        var fontS = 50
        
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
       
//        btn.addTarget(videoPlayerView, action: #selector(dismissVideoViewFirst), for: .touchUpInside)
        return btn
    }()
    
    @objc func dismissVideoView() {
        
        videoPlayerView.dismissVideoViewFirst()


    }
    
    func removeEverything() {
        equipmentLabel.removeFromSuperview()
        targetAreasLabel.removeFromSuperview()
        topTipsLabel.removeFromSuperview()
        topTipsLabelList.removeFromSuperview()
        seperatorView.removeFromSuperview()
        exerciseNameLabel.removeFromSuperview()
        dimissVideoLauncherButton.removeFromSuperview()
        
        
        equipmentLabelList.removeFromSuperview()
        targetAreasLabelList.removeFromSuperview()
        
    }
    
    @objc func restartTouch() {
         useSparinglyGenerateControllerGlobal.view.isUserInteractionEnabled = true
        restartTimerTouch.invalidate()
    }
    var restartTimerTouch = Timer()
    func closingAnimation() {
        removeEverything()
        useSparinglyGenerateControllerGlobal.view.isUserInteractionEnabled = false
      restartTimerTouch = Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(restartTouch), userInfo: nil, repeats: false)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view?.frame = CGRect(x: UIScreen.main.bounds.width - 5, y: UIScreen.main.bounds.height - 5, width: 0, height: 0)
//            self.view?.removeFromSuperview()
        }) { (completedAnimation) in
            
            self.view?.removeFromSuperview()
            if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView{
                statusBar.isHidden = false
            }
            
            
        }
        
        self.removeFromSuperview()
        isLaunched = false
        }
    
    lazy var videoPlayerView: VideoPlayerView = {
        let height = UIScreen.main.bounds.width * (53/80)
        
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        
        let view = VideoPlayerView(frame: videoPlayerFrame)
//        , url: launcherURL
        view.backgroundColor = UIColor.lightGray
        view.theParent = self
        return view
    }()
    
    let indentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 153/255, green: 244/255, blue: 255/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var view: UIView?


    
    func showVideoPlayer() {
        let screenHeighttt = UIScreen.main.bounds.height
        videoPlayerView.setupPlayerView()
        
        dimissVideoLauncherButton.addTarget(self, action: #selector(dismissVideoView), for: .touchUpInside)

        
        if let keyWindow = UIApplication.shared.keyWindow {
            
        
             view = UIView(frame: keyWindow.frame)
            view?.backgroundColor = UIColor.white
            
            view?.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
//            let height = keyWindow.frame.width * (9/16)
//            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
//            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view?.addSubview(videoPlayerView)
            videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
            
            if UIScreen.main.bounds.height > 800 {
                var indentConstant: CGFloat = 88
                if UIScreen.main.bounds.height > 850 {
                    indentConstant = 98
                }
                view?.addSubview(indentView)
                indentView.addSubview(exerciseNameLabel)
                indentView.addSubview(dimissVideoLauncherButton)
                dimissVideoLauncherButton.setTitleColor(UIColor.white, for: .normal)
                dimissVideoLauncherButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
                exerciseNameLabel.textColor = UIColor.white
                exerciseNameLabel.leftAnchor.constraint(equalTo: indentView.leftAnchor, constant: 14).isActive = true
                exerciseNameLabel.bottomAnchor.constraint(equalTo: indentView.bottomAnchor, constant: -6).isActive = true
                dimissVideoLauncherButton.rightAnchor.constraint(equalTo: indentView.rightAnchor, constant: -6).isActive = true
                dimissVideoLauncherButton.centerYAnchor.constraint(equalTo: exerciseNameLabel.centerYAnchor).isActive = true
                view?.addConstraintsWithFormat(format: "H:|[v0]|", views: indentView)
                
                
                view?.addConstraintsWithFormat(format: "V:|[v0(\(indentConstant))][v1(\(UIScreen.main.bounds.width * (53/80)))]", views: indentView, videoPlayerView)
                

                
                
            } else {
                view?.addConstraintsWithFormat(format: "V:|[v0(\(UIScreen.main.bounds.width * (53/80)))]", views: videoPlayerView)
                view?.addSubview(dimissVideoLauncherButton)
                view?.addConstraintsWithFormat(format: "V:|[v0]", views: dimissVideoLauncherButton)
                view?.addConstraintsWithFormat(format: "H:[v0]-4-|", views: dimissVideoLauncherButton)
            }

            
           let taArray = getTargetAreasVideoLauncher(exercise: currentWorkoutArray[currentExercise])
            var taText = ""
            var xCounter = 0
            for x in taArray {
                taText.append(x)
                xCounter = xCounter + 1
                if xCounter != taArray.count {
                    taText.append("\n")
                }
            }
            
            let eqArray = getEquipmentVideoLauncher(exercise: currentWorkoutArray[currentExercise])
            var eqText = ""
            var yCounter = 0
            for y in eqArray {
                eqText.append(y)
                yCounter = yCounter + 1
                if yCounter != eqArray.count {
                eqText.append("\n")
                }
            }
            
            var topTipsNameConstant: CGFloat = 18
            
            if screenHeighttt < 700 {
                topTipsNameConstant = 7
            } else if screenHeighttt < 750 {
                topTipsNameConstant = 10
            }
            
            
            if screenHeighttt < 800 {
            view?.addSubview(exerciseNameLabel)
            exerciseNameLabel.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 8).isActive = true
            view?.addConstraintsWithFormat(format: "H:|-14-[v0]|", views: exerciseNameLabel)
            
            view?.addSubview(topTipsLabel)
            topTipsLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: topTipsNameConstant).isActive = true
            view?.addConstraintsWithFormat(format: "H:|-14-[v0]|", views: topTipsLabel)
            } else {
                view?.addSubview(topTipsLabel)
                topTipsLabel.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 12).isActive = true
                view?.addConstraintsWithFormat(format: "H:|-14-[v0]|", views: topTipsLabel)
            }
            
            var topTipsTopConstant: CGFloat = 14
            var seperatorViewConstantBottom: CGFloat = (UIScreen.main.bounds.height / 4.1)
            if screenHeighttt > 800 {
                topTipsTopConstant = 14
                seperatorViewConstantBottom = (UIScreen.main.bounds.height / 4.1)
            } else if screenHeighttt > 700 {
                topTipsTopConstant = 14
                seperatorViewConstantBottom = (UIScreen.main.bounds.height / 4.1) - 8
                
            } else if screenHeighttt > 600 {
                topTipsTopConstant = 8
                seperatorViewConstantBottom = (UIScreen.main.bounds.height / 4.1) - 21
            } else {
                topTipsTopConstant = 4
                seperatorViewConstantBottom = (UIScreen.main.bounds.height / 4.1) - 23
            }
            
            
            view?.addSubview(topTipsLabelList)
            topTipsLabelList.topAnchor.constraint(equalTo: topTipsLabel.bottomAnchor, constant: topTipsTopConstant).isActive = true
            view?.addConstraintsWithFormat(format: "H:|-14-[v0]|", views: topTipsLabelList)
            
            topTipsLabelList.text = currentWorkoutArray[currentExercise].topTips
            if screenHeighttt > 850 {
                topTipsLabelList.lineHeight = 40
            } else if screenHeighttt > 700 {
                topTipsLabelList.lineHeight = 38
            } else if screenHeighttt > 600 {
                topTipsLabelList.lineHeight = 34
            } else {
                topTipsLabelList.lineHeight = 29
            }
            
            
            
            view?.addSubview(seperatorView)
            seperatorView.bottomAnchor.constraint(equalTo: view!.bottomAnchor, constant: -seperatorViewConstantBottom).isActive = true
            seperatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
            view?.addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
            
            var taAndEquipTopSpacing: CGFloat = 8
            if screenHeighttt < 600 {
                taAndEquipTopSpacing = 3
            }
            
            view?.addSubview(targetAreasLabel)
            targetAreasLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: taAndEquipTopSpacing).isActive = true
            view?.addConstraintsWithFormat(format: "H:|-14-[v0]", views: targetAreasLabel)
            
            view?.addSubview(equipmentLabel)
            view?.addConstraintsWithFormat(format: "H:[v0]-14-|", views: equipmentLabel)
            equipmentLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: taAndEquipTopSpacing).isActive = true
            
          view?.addSubview(targetAreasLabelList)
          
            
            
            
            
            
            targetAreasLabelList.leftAnchor.constraint(equalTo: targetAreasLabel.leftAnchor).isActive = true
           targetAreasLabelList.topAnchor.constraint(equalTo: targetAreasLabel.bottomAnchor, constant: taAndEquipTopSpacing).isActive = true

            targetAreasLabelList.numberOfLines = taArray.count
            targetAreasLabelList.text = taText
            if screenHeighttt > 800 {
                targetAreasLabelList.lineHeight = 40
            } else if screenHeighttt > 700 {
            targetAreasLabelList.lineHeight = 34
            }  else if screenHeighttt > 600 {
                targetAreasLabelList.lineHeight = 27
            } else {
                targetAreasLabelList.lineHeight = 25
            }
            
            view?.addSubview(equipmentLabelList)
            
            equipmentLabelList.rightAnchor.constraint(equalTo: equipmentLabel.rightAnchor).isActive = true
            equipmentLabelList.topAnchor.constraint(equalTo: targetAreasLabel.bottomAnchor, constant: taAndEquipTopSpacing).isActive = true

            
            
            if eqArray.count == 0 {
                equipmentLabelList.numberOfLines = 1
                equipmentLabelList.text = "No Equipment"
            } else {
                
                equipmentLabelList.numberOfLines = eqArray.count
                equipmentLabelList.text = eqText
            }

            if screenHeighttt > 800 {
            equipmentLabelList.lineHeight = 40
            } else if screenHeighttt > 700 {
            equipmentLabelList.lineHeight = 34
            } else if screenHeighttt > 600 {
                equipmentLabelList.lineHeight = 27
            } else {
                equipmentLabelList.lineHeight = 25
            }
            
//            equipmentLabelList.textAlignment = .right
            
            
            

            keyWindow.addSubview((view)!)
            
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view?.frame = keyWindow.frame
            }) { (completedAnimation) in

                if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView{
                    if screenHeighttt > 800 {
                    statusBar.isHidden = false
                    
                    } else {
                        statusBar.isHidden = true
                    }
                }
  
            
            }
        }
        
    }

}
