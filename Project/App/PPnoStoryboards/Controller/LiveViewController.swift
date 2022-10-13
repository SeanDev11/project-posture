//
//  LiveViewController.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 27.09.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

var globalCurrentScreenIndexLive = 0

class LiveViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        globalCurrentScreenIndexLive = 0
        setupCollectionView()
        setupViews()
        

        
        startTapped()

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
        let screenHeight = UIScreen.main.bounds.height
        
        view.addSubview(endButton)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: endButton)
        if screenHeight > 800 {
            view.addConstraintsWithFormat(format: "V:[v0(43)]-80-|", views: endButton)
        } else if screenHeight > 600 {
            view.addConstraintsWithFormat(format: "V:[v0(38)]-49-|", views: endButton)
        } else {
            view.addConstraintsWithFormat(format: "V:[v0(30)]-49-|", views: endButton)
        }
        
        view.addSubview(topView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: topView)
        if screenHeight > 600 {
        view.addConstraintsWithFormat(format: "V:|[v0(45)]", views: topView)
        } else {
        view.addConstraintsWithFormat(format: "V:|[v0(38)]", views: topView)
        }
//        view.addSubview(seperatorView)
//        under timer
        
        topView.addSubview(totalTimeRemainingLabel)
        if screenHeight > 850 {
            topView.addConstraintsWithFormat(format: "H:|-50-[v0]", views: totalTimeRemainingLabel)
        } else if screenHeight > 700 {
            topView.addConstraintsWithFormat(format: "H:|-42-[v0]", views: totalTimeRemainingLabel)
        } else if screenHeight > 600 {
            topView.addConstraintsWithFormat(format: "H:|-30-[v0]", views: totalTimeRemainingLabel)
        } else {
            topView.addConstraintsWithFormat(format: "H:|-15-[v0]", views: totalTimeRemainingLabel)
        }
        
        topView.addConstraintsWithFormat(format: "V:|[v0]|", views: totalTimeRemainingLabel)

        topView.addSubview(timerLabel)
        topView.addConstraint(NSLayoutConstraint(item: timerLabel, attribute: .left, relatedBy: .equal, toItem: totalTimeRemainingLabel, attribute: .right, multiplier: 1, constant: 8))
        topView.addConstraint(NSLayoutConstraint(item: timerLabel, attribute: .centerY, relatedBy: .equal, toItem: totalTimeRemainingLabel, attribute: .centerY, multiplier: 1, constant: 1.5))
        
        
        var subTimerConstant = 50 + (UIScreen.main.bounds.width * (9 / 16)) + 100
        if screenHeight > 850 {
            subTimerConstant = (UIScreen.main.bounds.width * (9 / 16)) + 170
        } else if screenHeight > 800 {
            subTimerConstant = (UIScreen.main.bounds.width * (9 / 16)) + 155
        } else if screenHeight > 700 {
            subTimerConstant = (UIScreen.main.bounds.width * (9 / 16)) + 145
        } else if screenHeight > 600 {
            subTimerConstant = (UIScreen.main.bounds.width * (9 / 16)) + 130
        } else {
            subTimerConstant = (UIScreen.main.bounds.width * (9 / 16)) + 107
        }
        
        
        view.addSubview(subTimerLabel)
        view.addSubview(subTimerReset)
        view.addConstraintsWithFormat(format: "V:|-\(subTimerConstant - 10)-[v0]", views: subTimerLabel)
        view.addConstraint(NSLayoutConstraint(item: subTimerLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        var subResetVert: CGFloat = 25
        var dividerHorizontal: CGFloat = 4.8
        if screenHeight > 850 {
            subResetVert = 25
        } else if screenHeight > 800 {
            subResetVert = 18
            dividerHorizontal = 4.8
        } else if screenHeight > 700 {
            subResetVert = 17
            dividerHorizontal = 4
        } else if screenHeight > 600 {
            subResetVert = 16
            dividerHorizontal = 4.28
        } else {
            subResetVert = 12.9
            dividerHorizontal = 4
        }
        
        view.addConstraint(NSLayoutConstraint(item: subTimerReset, attribute: .top, relatedBy: .equal, toItem: subTimerLabel, attribute: .top, multiplier: 1, constant: subResetVert))
        subTimerReset.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -(UIScreen.main.bounds.width / dividerHorizontal)).isActive = true
        var buttonConstant: CGFloat = 15
        if screenHeight > 850 {
            buttonConstant = 25
        } else if screenHeight > 800 {
            buttonConstant = 23
        } else if screenHeight > 700 {
            buttonConstant = 10
        } else if screenHeight > 600 {
            buttonConstant = 8
        } else {
            buttonConstant = 3
        }
        
        let screenWid = UIScreen.main.bounds.width
        view.addSubview(subTimerPausePlay)
        subTimerPausePlay.leftAnchor.constraint(equalTo: view.leftAnchor, constant: screenWid / 3.3).isActive = true
        subTimerPausePlay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -(screenWid / 3.3)).isActive = true
        view.addConstraint(NSLayoutConstraint(item: subTimerPausePlay, attribute: .top, relatedBy: .equal, toItem: subTimerLabel, attribute: .bottom, multiplier: 1, constant: buttonConstant))
        
    }
    
   private func setupCollectionView() {
        
        collectionView.register(HorizontalLiveViewCell.self, forCellWithReuseIdentifier: "LiveView")
        let screenH = UIScreen.main.bounds.height

        if screenH > 850 {
        collectionView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 340.5, right: 0)
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 45, left: 0, bottom: 340.5, right: 0)
        } else if screenH > 800 {
            collectionView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 298, right: 0)
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 45, left: 0, bottom: 298, right: 0)
            
        } else if screenH > 700 {
            collectionView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 254, right: 0)
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 45, left: 0, bottom: 254, right: 0)
        } else if screenH > 600 {
            collectionView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 223, right: 0)
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 45, left: 0, bottom: 223, right: 0)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 38, left: 0, bottom: 167, right: 0)
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 38, left: 0, bottom: 167, right: 0)
        }
        

        collectionView.backgroundColor = UIColor.white

        collectionView?.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    let endButton: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("End Workout", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
         let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight > 800 {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 33)
            
        } else if screenHeight > 600 {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
        } else {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            
        }

        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        btn.addTarget(self, action: #selector(workoutEnded), for: .touchUpInside)
       return btn
    }()
    
    var isWorkoutEnded = 0
    
    @objc func workoutEnded() {
        
        if isWorkoutEnded == 0 {
        let endView = WorkoutCompletedView()
        let total: Int = Int(endView.calcDuration(workout: currentWorkoutArray)) / 60
        let currentProgress = defaults.integer(forKey: "DailyProgress")
        defaults.set(total + currentProgress, forKey: "DailyProgress")
        
        WeeklyService.updateThisWeek(addedTime: Int16(total))
        
        
        Streak.update()
        
            if let tabbarItems = useSparinglyGenerateControllerGlobal.tabBarController?.tabBar.items {
                
                tabbarItems[0].isEnabled = true
                tabbarItems[1].isEnabled = true
                tabbarItems[2].isEnabled = true
                
            }
            
            globalCurrentScreenIndexLive = 0
            
            
        navigationController?.pushViewController(endView, animated: true)
        
        
        disableEveryting()
        self.removeFromParent()
            
            isWorkoutEnded = 1
        }
    }
    
    func disableEveryting() {
        timer.invalidate()
        delayTimer.invalidate()
        countdownTimer.invalidate()
        subTimer.invalidate()
//        audioDelayTimer.invalidate()
        speakTimer.invalidate()
    }
    
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
       return view
    }()
    
    let totalTimeRemainingLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "Total Time Remaining:"
        if screenH > 600 {
            label.font = UIFont.systemFont(ofSize: 25)
        } else {
            label.font = UIFont.systemFont(ofSize: 23)
        }
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let timerLabel: UILabel = {
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        if screenH > 600 {
        label.font = UIFont.systemFont(ofSize: 25)
        } else {
            label.font = UIFont.systemFont(ofSize: 23)
        }
        return label
    }()
    
    let subTimerLabel: UILabel = {
        
        let screenH = UIScreen.main.bounds.height
        let label = UILabel()
        label.text = "00"
        label.textColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
//        80 for systemfont
//        label.font = UIFont.systemFont(ofSize: 80)
        if screenH > 850 {
            label.font = UIFont.monospacedDigitSystemFont(ofSize: 130, weight: UIFont.Weight.ultraLight)
//            label.font = UIFont.systemFont(ofSize: 120, weight: UIFont.Weight.ultraLight)
        } else if screenH > 700 {
            
            label.font = UIFont.monospacedDigitSystemFont(ofSize: 95, weight: UIFont.Weight.ultraLight)
        } else if screenH > 600 {
            label.font = UIFont.monospacedDigitSystemFont(ofSize: 88, weight: UIFont.Weight.ultraLight)
        } else {
            
            label.font = UIFont.monospacedDigitSystemFont(ofSize: 70, weight: UIFont.Weight.ultraLight)
        }
        
        return label
    }()
    

    
    let subTimerReset: UIButton = {
        let btn = UIButton()
        var imageString = "reloadd"
        if UIScreen.main.bounds.height > 600 {
            imageString = "reloadd"
        } else {
            imageString = "reloaddSmall"
        }

        let image = UIImage(named: imageString)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
       return btn
        
    }()
    
    let subTimerPausePlay: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false

        var imageString = "ppause"
        if UIScreen.main.bounds.height > 700 {
            imageString = "ppause"
        } else {
            imageString = "ppauseSmall"
        }
        let image = UIImage(named: imageString)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        btn.addTarget(self, action: #selector(pausePlayTapped), for: .touchUpInside)
        return btn
    }()
    
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var loadedView = false
    var firstLaunch = true
    
    private func calcDurationWorkout(workout: [ExerciseObject]) -> Int16 {
        var total: Int16 = 0
        
        for x in 0...(workout.count - 1) {
            total = total + workout[x].duration
        }
        return total
    }
    
    
   @objc func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    subTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSubTimer), userInfo: nil, repeats: true)
    isSubTimerRunning = true
     isTimerRunning = true
    
    isWorkoutEnded = 0
    }
    
    @objc func startTapped() {
        
        if let tabbarItems = useSparinglyGenerateControllerGlobal.tabBarController?.tabBar.items {
            
            tabbarItems[0].isEnabled = false
            tabbarItems[1].isEnabled = false
            tabbarItems[2].isEnabled = false

        
        }

        
        seconds = Int(self.calcDurationWorkout(workout: currentWorkoutArray))
        secondsSub = Int(currentWorkoutArray[0].duration)
        
        let totalTime = calcDurationWorkout(workout: currentWorkoutArray)
        let firstTime = currentWorkoutArray[0].duration
        timerLabel.text = timeString(time: TimeInterval(totalTime))
        subTimerLabel.text = "\(firstTime)"
        view.isUserInteractionEnabled = false
        beginsIn()
            
//        if isTimerRunning == false && isSubTimerRunning == false {
////            runTimer()
//        }
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            workoutEnded()
            
        } else {
            loadedView = true
        seconds = seconds - 1
            timerLabel.text = (timeString(time: TimeInterval(seconds)))
        }
    }
    
    @objc func pausePlayTapped() {
        
        speakTimer.invalidate()
        delayTimer.invalidate()
        countdownTimer.invalidate()
        switchSideTimer.invalidate()
        synthesizer.stopSpeaking(at: .immediate)
        
        var imageStringPlay = "play-1"
        var imageStringPause = "ppause"
        if UIScreen.main.bounds.height > 700 {
            imageStringPlay = "play-1"
            imageStringPause = "ppause"
        } else {
            imageStringPlay = "playSmall"
            imageStringPause = "ppauseSmall"
        }
        
        
        if self.resumeTapped == false {
            
            let image = UIImage(named: imageStringPlay)?.withRenderingMode(.alwaysTemplate)
            subTimerPausePlay.setImage(image, for: .normal)
            timer.invalidate()
            subTimer.invalidate()
            self.resumeTapped = true
    
        } else {
            let image = UIImage(named: imageStringPause)?.withRenderingMode(.alwaysTemplate)
            subTimerPausePlay.setImage(image, for: .normal)
            
            runTimer()
            
            self.resumeTapped = false
//            SET ICON TO PAUSE
        }
        
    }
    
    @objc func resetTimer() {
        
        var imageStringPause = "ppause"
        if UIScreen.main.bounds.height > 600 {
            imageStringPause = "ppause"
        } else {
            imageStringPause = "ppauseSmall"
        }
        
        if self.resumeTapped == true {
            
            let image = UIImage(named: imageStringPause)?.withRenderingMode(.alwaysTemplate)
            subTimerPausePlay.setImage(image, for: .normal)
            
            self.resumeTapped = false
            //            SET ICON TO PAUSE
        }
        
        synthesizer.stopSpeaking(at: .immediate)
        delayTimer.invalidate()
        speakTimer.invalidate()
        countdownTimer.invalidate()
        
        timer.invalidate()
        subTimer.invalidate()
//        reset sub timer and add its time to the toptimer
        let resetValue = Int(currentWorkoutArray[globalCurrentScreenIndexLive].duration) - secondsSub
        secondsSub = Int(currentWorkoutArray[globalCurrentScreenIndexLive].duration)
        seconds = seconds + resetValue
        
        timerLabel.text = timeString(time: TimeInterval(seconds))
        subTimerLabel.text = "\(secondsSub)"
        isTimerRunning = false
        isSubTimerRunning = false
        runTimer()
    }
    
    func timeString(time: TimeInterval) -> String {
        
        let minutes = Int(time) / 60 % 60
        let secondsFormatted = Int(time) % 60
        
        return String(format: "%02i:%02i", minutes, secondsFormatted)

    }
    
    var secondsSub = 30
    var subTimer = Timer()
    var isSubTimerRunning = false
    
    var switchSideTimer = Timer()
    
    @objc func updateSubTimer() {
        if secondsSub < 1 {
            subTimer.invalidate()
            isSubTimerRunning = false
            if globalCurrentScreenIndexLive < currentWorkoutArray.count - 1 {
                pauseTopTimer()
            scrollToMenuIndex(menuIndex: globalCurrentScreenIndexLive + 1)
            }
            //            if its less than the amount of exercises - 1
        } else {
            secondsSub = secondsSub - 1
            subTimerLabel.text = "\(secondsSub)"
            if secondsSub == 30 && currentWorkoutArray[globalCurrentScreenIndexLive].switchSides {
                pausePlayTapped()
                utterance = AVSpeechUtterance(string: "Switch sides.")
                synthesizer.speak(utterance)
                switchSideTimer = Timer.scheduledTimer(timeInterval: 3.2, target: self, selector: #selector(switchSidesMethod), userInfo: nil, repeats: false)
                
            }

        }
    }
    
    @objc func switchSidesMethod() {
        
        utterance = AVSpeechUtterance(string: "Continue.")
        synthesizer.speak(utterance)
        switchSideTimer.invalidate()
        switchSideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pausePlayTapped), userInfo: nil, repeats: false)
        
    }
    
    @objc func setSubTimer(time: Int) {
        if isSubTimerRunning == false {
        secondsSub = time
        subTimerLabel.text = "\(secondsSub)"
        
//        runSubTimer()
        } else {
            subTimer.invalidate()
            secondsSub = time
            subTimerLabel.text = "\(secondsSub)"
            
//            runSubTimer()
        }
        
    }
    
    @objc func runSubTimer() {
        
        subTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSubTimer), userInfo: nil, repeats: true)
        
        isSubTimerRunning = true
//        playTopTimer()
    }
  
    @objc func runTopTimer() {
        
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        
    }
    
    var delayTimer = Timer()
    
    @objc func delay() {
            
        delayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTopTimer), userInfo: nil, repeats: false)
        
    }
    
    @objc func pauseTopTimer() {
        
        timer.invalidate()
    }
    
    @objc func playTopTimer() {
        runTopTimer()
    }
    
    @objc func pauseSubTimer() {
        subTimer.invalidate()
    }
    
    @objc func playSubTimer() {
        runSubTimer()
    }
    
    func updateTopForward() {
        
        seconds = seconds - secondsSub
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func updateTopWithVelocity(velocity: CGPoint) {
        if velocity.x > 0 {
        seconds = seconds - secondsSub
        } else {
            let difference: Int = Int(currentWorkoutArray[globalCurrentScreenIndexLive + 1].duration) - secondsSub
            seconds = seconds + Int(currentWorkoutArray[globalCurrentScreenIndexLive].duration) + difference
        }
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    
    var utterance = AVSpeechUtterance()
    var synthesizer = AVSpeechSynthesizer()
    let voice = AVSpeechSynthesisVoice(identifier: "en-US")
    var countdownNumber = 0
    var speakTimer: Timer = Timer()
    var countdownTimer: Timer = Timer()
//    var audioDelayTimer: Timer = Timer()
    
    func beginsIn() {
        synthesizer.stopSpeaking(at: .immediate)
        countdownNumber = 0
        
        speakTimer.invalidate()
        countdownTimer.invalidate()
        pauseTopTimer()
        pauseSubTimer()
        synthesizer = AVSpeechSynthesizer()
        

        
        let exerciseName = currentWorkoutArray[globalCurrentScreenIndexLive].name
        let exerciseDuration = currentWorkoutArray[globalCurrentScreenIndexLive].duration
        
       
        utterance = AVSpeechUtterance(string: "\(exerciseName) for \(exerciseDuration) seconds begins in")
        utterance.volume = 1
        utterance.voice = voice
        synthesizer.speak(utterance)
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.95, target: self, selector: #selector(delayForCountdown), userInfo: nil, repeats: false)
    }
    
    
    @objc func delayForCountdown() {
        countdownTimer.invalidate()
    
        speakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownSpeak), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func countdownSpeak() {
        
            utterance.volume = 1
            utterance = AVSpeechUtterance(string: "\(5-countdownNumber)")
            synthesizer.speak(utterance)
        

        if countdownNumber < 4 {
        countdownNumber = countdownNumber + 1
        } else {
            countdownNumber = 0
            speakTimer.invalidate()
            countdownTimer.invalidate()

            
            if firstLaunch {
                view.isUserInteractionEnabled = true
            }
            firstLaunch = false
            playTopTimer()
            playSubTimer()
            
        }
    }
    
    
    
    

    
    
    
    func scrollToMenuIndex(menuIndex: Int) {
        pauseTopTimer()
        let indexPath = NSIndexPath(item: 0, section: menuIndex)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)

        globalCurrentScreenIndexLive = menuIndex
        
    }
    

    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if loadedView == true && globalCurrentScreenIndexLive < currentWorkoutArray.count {
            
//            pauseTopTimer()
            
            updateTopForward()
            seconds = seconds + 1
            
            timerLabel.text = timeString(time: TimeInterval(seconds))
            
            beginsIn()
            
            setSubTimer(time: Int(currentWorkoutArray[globalCurrentScreenIndexLive].duration))
//            if currentScreenIndex == 1 {
//            delay()
//            } else {
//                playTopTimer()
//            }
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if globalCurrentScreenIndexLive != Int(targetContentOffset.pointee.x / view.frame.width) {
        
        globalCurrentScreenIndexLive = Int(targetContentOffset.pointee.x / view.frame.width)
        if loadedView == true && globalCurrentScreenIndexLive < currentWorkoutArray.count {
            updateTopWithVelocity(velocity: velocity)
            
            beginsIn()
            
//            pauseTopTimer()
            setSubTimer(time: Int(currentWorkoutArray[globalCurrentScreenIndexLive].duration))
            
//                playTopTimer()
        }
        }
    }
    

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return currentWorkoutArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ID: String = "LiveView"

        currentExercise = indexPath.section
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! HorizontalLiveViewCell

        
//        cell.videoView.setupPlayerViewCV(video: currentWorkoutArray[indexPath.section].videoLink)
//        cell.videoView.theItem = AVPlayerItem(url: URL(fileURLWithPath: currentWorkoutArray[currentExercise].videoLink ?? ""))
//        cell.videoView.playerLooper = AVPlayerLooper(player: cell.videoView.player!, templateItem: cell.videoView.theItem!)
        cell.nameLabel.text = currentWorkoutArray[currentExercise].name
        
        return cell

    }
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIScreen.main.bounds.height > 850 {
            return CGSize(width: view.frame.width, height: view.frame.width * (53 / 80) + 65)
            
        } else if UIScreen.main.bounds.height > 800  {
            
            return CGSize(width: view.frame.width, height: view.frame.width * (53 / 80) + 50)
            
        } else if UIScreen.main.bounds.height > 700 {
            return CGSize(width: view.frame.width, height: view.frame.width * (53 / 80) + 50)
            
        } else if UIScreen.main.bounds.height > 600 {
            
            return CGSize(width: view.frame.width, height: (view.frame.width * (53 / 80)) + 38)
            
        } else {
            
            return CGSize(width: view.frame.width, height: (view.frame.width * (53 / 80)) + 38 )
            
        }
        
    }
    
    
    
    
    
    
    
}
