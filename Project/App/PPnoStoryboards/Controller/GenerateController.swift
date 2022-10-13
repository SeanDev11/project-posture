//
//  ViewController.swift
//  PPnoStoryboards
//  Created by Sean Devine on 18.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit
import Foundation



class GenerateController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let morningRoutineArray: [ExerciseObject] = [allExercises.searchExercises(forThis: "Chest Stretch"), allExercises.searchExercises(forThis: "Lat Stretch"), allExercises.searchExercises(forThis: "Wall Slides"), allExercises.searchExercises(forThis: "Floor Reach"), allExercises.searchExercises(forThis: "Sprinter Lunge"), allExercises.searchExercises(forThis: "Heel Squat")]
    
    let nightRoutineArray: [ExerciseObject] = [allExercises.searchExercises(forThis: "Lunge Stretch"), allExercises.searchExercises(forThis: "Butterfly Stretch"), allExercises.searchExercises(forThis: "Chest Stretch"), allExercises.searchExercises(forThis: "Wall Brace"), allExercises.searchExercises(forThis: "Lying Y's"), allExercises.searchExercises(forThis: "Heel Squat")]
    
    
    
    var viewIsLoaded = false
    var hahajk = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuBar()
        self.definesPresentationContext = true
        popUp.modalPresentationStyle = .overCurrentContext
        popUpT.modalPresentationStyle = .overCurrentContext
        settingsPopUp.modalPresentationStyle = .overCurrentContext
        popUpEquipment.modalPresentationStyle = .overCurrentContext
        popUpDailyGoal.modalPresentationStyle = .overCurrentContext
      
        setupCollectionView()
        setupNavBar()
        setupGenerateButton()
//        setup nav bar was here
        
        
        
        if defaults.integer(forKey: "DailyGoal") == 0 {
            
            defaults.set(10, forKey: "DailyGoal")
        }
        
        if defaults.integer(forKey: "TotalTime") == 0  {
            
            defaults.set(0, forKey: "TotalTime")
        }
        
        if defaults.integer(forKey: "TotalWorkouts") == 0  {
            
            defaults.set(0, forKey: "TotalWorkouts")
        }
        
        if defaults.integer(forKey: "TimeLimit") == 0 {
            defaults.set(7, forKey: "TimeLimit")
        }

        useSparinglyGenerateControllerGlobal = self
        
        
    }
    
    var dailyGoal = 15
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        

//        collectionView.reloadData()
//        collectionView.layoutSubviews()
//        let indexPathP = IndexPath(item: 1, section: 0)
//        collectionView.reloadItems(at: [indexPathP])
        
        
    }
    
    

   @objc public func reloadDailyGoalView() {

        let indexPath = IndexPath(item: 1, section: 0)
        let indexP = IndexPath(item: 3, section: 0)
        if let theMainOne = collectionView.cellForItem(at: indexPath) {
            let generateCV: generateCellCV = theMainOne as! generateCellCV
//            generateCV.collectionView.reloadData()
            if let dailyGoalCell = generateCV.collectionView.cellForItem(at: indexP) {
                let dailyGoalC: dailyGoalViewCell = dailyGoalCell as! dailyGoalViewCell
                dailyGoalC.minutesLabel.text = "\(defaults.integer(forKey: "DailyProgress"))"
                
                dailyGoalC.animateCircle()
                
            }
            
            
        }
  
    }
    
    
    
    private func setupCollectionView() {

        collectionView.register(generateCellCV.self, forCellWithReuseIdentifier: "selectorID")
    
        collectionView.register(morningNightCell.self, forCellWithReuseIdentifier: "morningNightCell")
        
//        WORK on this ADAPTABLE based on generateBUtton
        if UIScreen.main.bounds.height > 850 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 52, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 52, right: 0)
            
        } else if UIScreen.main.bounds.height > 800 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 48, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 48, right: 0)
            
        } else if UIScreen.main.bounds.height > 700 {
            
            collectionView?.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            
            
        } else if UIScreen.main.bounds.height > 600 {
        
        collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 38, right: 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 38, right: 0)
            
            
        } else {
            
            collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 30, right: 0)
            
            collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 30, right: 0)
            
        }
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView?.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    

    let popUp = popUpTA()
    let filler = Filler()
    var popUpT = popUpTime()
    let popUpEquipment = PopUpEquipment()
    let popUpDailyGoal = DailyGoalPopUp()
    
    lazy var navBarHeight: CGFloat = {
        
        let height: CGFloat = (self.navigationController?.navigationBar.bounds.height ?? 44)
            
        return height
  
    }()
    
     let screenWidthGen = UIScreen.main.bounds.width
    let screenHeightGen = UIScreen.main.bounds.height
    
    
    let selectorCellHeight: CGFloat = {
        
        let screenHeight = UIScreen.main.bounds.height
        var height: CGFloat = 350
        
        if screenHeight > 850 {
            height = screenHeight / 7.5
        } else if screenHeight > 800 {
            height = 667 / 6.6368
        } else {
            height = screenHeight / 6.6368
        }
 
        return height
    }()
    

    lazy var menuBar: MenuBar = {
        
        let mb = MenuBar()
        mb.backgroundColor = UIColor.lightGray
        mb.homeController = self
        return mb
        
    }()
    
    let generateButton: UIButton = {
        
        let screenHeight = UIScreen.main.bounds.height
        
        let button = UIButton()
        button.setTitle("Begin", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        
        if screenHeight > 800 {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 31)

        } else if screenHeight > 600 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)

        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)

        }
        
      
    
        
        button.backgroundColor = UIColor(red: 122/255, green: 120/255, blue: 120/255, alpha: 1)
        
        button.addTarget(self, action: #selector(generatePressed), for: .touchUpInside)
       
        return button
    }()
    

    
    var currentScreenIndex = 0
    
 private func setupNavBar() {
    
        let titleLabel = UILabel()
        titleLabel.text = "P|P"
    if UIScreen.main.bounds.height > 850 {
        titleLabel.font = UIFont.systemFont(ofSize: 26)
    } else {
        titleLabel.font = UIFont.systemFont(ofSize: 24)
    }
    titleLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    
        navigationItem.titleView = titleLabel

        navigationController?.navigationBar.isTranslucent = false
    
    let moreButton = UIBarButtonItem(image: UIImage(named: "SettingsIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    moreButton.tintColor = UIColor.white
   
    navigationItem.rightBarButtonItem = moreButton
    
    navigationController?.navigationBar.reloadInputViews()
    }
    
   @objc func handleMore() {
// Settings popup that updates dailygoal userdefault,    reminders
//    DISABLE TAB BAR
    
    
    if globalSettingsIsLaunched == false {
    self.present(settingsPopUp, animated: true)
        globalSettingsIsLaunched = true
    }
    
 
    }
    
    @objc func plusButtonPressed(sender: UIButton) {
        let plusButtonTag = sender.tag
        
        globalSettingsIsLaunched = true


        if plusButtonTag == 0 {
            
          self.present(popUp, animated: true)
        } else if plusButtonTag == 1 {
            
            self.present(popUpEquipment, animated: true)
        } else if plusButtonTag == 2 {
            
            var allFalse = false
            if defaults.bool(forKey: "AnteriorPelvicTilt") == false && defaults.bool(forKey: "ForwardNeck") == false && defaults.bool(forKey: "RoundedShoulders") == false {
                allFalse = true
            }
            
            
            
            if defaults.integer(forKey: "TimeLimit") == 0  || allFalse {
                
                let alertController = UIAlertController(title: "Please Select a Target Area", message:
                    nil, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
            popUpT = popUpTime()
            popUpT.modalPresentationStyle = .overCurrentContext
            self.present(popUpT, animated: true)
            }
        }
    }
    
    @objc func editDailyGoal() {
        
        globalSettingsIsLaunched = true

        self.present(popUpDailyGoal, animated: true)
    }
    
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(40)]", views: menuBar)
        
        

    }
    
    
    
    @objc func generatePressed() {
        
        
        
        
        let index = IndexPath(item: 1, section: 0)
        collectionView.scrollToItem(at: index, at: [], animated: false)
//        let workoutArray = generateRoutine()
        if currentScreenIndex == 0 {
            
            currentWorkoutArray = morningRoutineArray
            
           
            
            let layoutMorning = UICollectionViewFlowLayout()
            layoutMorning.scrollDirection = .horizontal
            layoutMorning.minimumLineSpacing = 0
            
            let liveViewMorning = LiveViewController(collectionViewLayout: layoutMorning)
            navigationController?.pushViewController(liveViewMorning, animated: true)
            
            
        } else if currentScreenIndex == 1 {
            
            let aptBool = defaults.bool(forKey: "AnteriorPelvicTilt")
            let rsBool = defaults.bool(forKey: "RoundedShoulders")
            let fnBool = defaults.bool(forKey: "ForwardNeck")
            
            
            if aptBool || rsBool || fnBool {
            currentWorkoutArray = generateRoutine()
//                MARKED
//             usleep(100000)
                
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
//   pass the workout array
        let newView = GeneratedRoutineView(collectionViewLayout: layout)
        
        navigationController?.pushViewController(newView, animated: true)
            } else {
                
                let alertController = UIAlertController(title: "Please Select a Target Area", message:
                   nil, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
                
            }
        } else {
            
            
            currentWorkoutArray = nightRoutineArray
            
            let layoutNight = UICollectionViewFlowLayout()
            layoutNight.scrollDirection = .horizontal
            layoutNight.minimumLineSpacing = 0
            
            let liveViewNight = LiveViewController(collectionViewLayout: layoutNight)
            navigationController?.pushViewController(liveViewNight, animated: true)
            
        }
        
        
    }
    
    func generateRoutine() -> [ExerciseObject] {
        
        var generatedWithoutEquipment: [ExerciseObject] = []
        var generatedArray: [ExerciseObject] = []
        var finalArray: [ExerciseObject] = []
        let aptBool = defaults.bool(forKey: "AnteriorPelvicTilt")
        let rsBool = defaults.bool(forKey: "RoundedShoulders")
        let fnBool = defaults.bool(forKey: "ForwardNeck")
        let timeLimit = (defaults.integer(forKey: "TimeLimit")) * 60
        
        
        
        if aptBool {
            
            let apt = self.allAPT()
            for element in apt {
                generatedArray.append(element)
            }
            
        }
        if rsBool {
            let rs = self.allRS()
            for element in rs {
                generatedArray.append(element)
            }
        }
        if fnBool {
            let fn = self.allFN()
            for element in fn {
                generatedArray.append(element)
            }
        }
        
        if defaults.bool(forKey: "ResistanceBand") {
            for x in 0...generatedArray.count - 1 {
                if generatedArray[x].resistanceBand {
                    generatedWithoutEquipment.append(generatedArray[x])
                    
                }
            }
        }
        
        if defaults.bool(forKey: "Pullup") {
            for x in 0...generatedArray.count - 1 {
                if generatedArray[x].pullUp {
                    generatedWithoutEquipment.append(generatedArray[x])
                }
            }
        }
        
        if defaults.bool(forKey: "Broomstick") {
            for x in 0...generatedArray.count - 1 {
                if generatedArray[x].broomstick {
                    generatedWithoutEquipment.append(generatedArray[x])
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
        
       
        
        
        let aptCount = self.allAPT().count
        let rsCount = self.allRS().count
        let fnCount = self.allFN().count
        var totalTime = 0
        var generatedExercise: ExerciseObject
        var aptCurrentCount = 0
        var rsCurrentCount = 0
        var fnCurrentCount = 0

        
        while totalTime < timeLimit {
            
            aptCurrentCount = 0
            rsCurrentCount = 0
            fnCurrentCount = 0
            if aptBool &&  totalTime < timeLimit {
                for x in finalArray {
                    if x.anteriorPelvicTilt {
                        aptCurrentCount = aptCurrentCount + 1
                    }
                }
                if aptCurrentCount != aptCount {
                 generatedExercise = getExercise(inArray: generatedWithoutEquipment, withArea: "APT")
                if finalArray.contains(generatedExercise) {
                    generatedExercise = checkForDuplicate(array: finalArray, exercise: generatedExercise, toGetArray: generatedWithoutEquipment, targetArea: "APT")
                }
                finalArray.append(generatedExercise)
                totalTime = totalTime + Int(generatedExercise.duration)
                }
            }
            
            if rsBool &&  totalTime < timeLimit {
                rsCurrentCount = 0
                for x in finalArray {
                    if x.roundedShoulders {
                        rsCurrentCount = rsCurrentCount + 1
                    }
                }
                
                if rsCurrentCount != rsCount {
                generatedExercise = getExercise(inArray: generatedWithoutEquipment, withArea: "RS")
                if finalArray.contains(generatedExercise) {
                    generatedExercise = checkForDuplicate(array: finalArray, exercise: generatedExercise, toGetArray: generatedWithoutEquipment, targetArea: "RS")
                }
                finalArray.append(generatedExercise)
                totalTime = totalTime + Int(generatedExercise.duration)
                    
                }
            }
            
            if fnBool &&  totalTime < timeLimit {
                for x in finalArray {
                    if x.forwardNeck {
                        fnCurrentCount = fnCurrentCount + 1
                    }
                }
                if fnCurrentCount != fnCount {
                generatedExercise = getExercise(inArray: generatedWithoutEquipment, withArea: "FN")
                if finalArray.contains(generatedExercise) {
                    generatedExercise = checkForDuplicate(array: finalArray, exercise: generatedExercise, toGetArray: generatedWithoutEquipment, targetArea: "FN")
                }
                finalArray.append(generatedExercise)
                totalTime = totalTime + Int(generatedExercise.duration)
                }
            }
            
        }
        
        
        
        var additionalArea = ""
        if aptBool {
            additionalArea = "APT"
        } else if rsBool {
            additionalArea = "RS"
        }
        else {
            additionalArea = "FN"
        }
        
        var intermediateArray: [ExerciseObject] = finalArray
        let difference = totalTime - timeLimit
        if difference != 0 {
            if difference < 0 {
                if difference % 60 == 0 {
                    
                    generatedExercise = getExerciseWithTime(time: 60, array: generatedWithoutEquipment, area: additionalArea, toAddArray: intermediateArray)
                    
                    finalArray.append(generatedExercise)
                } else {
                    generatedExercise = getExerciseWithTime(time: 30, array: generatedWithoutEquipment, area: additionalArea, toAddArray: intermediateArray)
                    finalArray.append(generatedExercise)
                }
                
            } else {
                if difference % 60 == 0 {
                     intermediateArray = removeExerciseWith(time: 60, array: finalArray)
                    
                } else {
                    intermediateArray = removeExerciseWith(time: 30, array: finalArray)
                }
            }
            
            finalArray = intermediateArray
        }
        
        return finalArray
    }
    
    private func checkForDuplicate(array: [ExerciseObject], exercise: ExerciseObject, toGetArray: [ExerciseObject], targetArea: String) -> ExerciseObject {
        var nonDuplicate: ExerciseObject = exercise
        

        var getExerciseFromHere: [ExerciseObject] = []
        if targetArea == "APT" {
            let allAPT = self.allAPT()
            for x in allAPT {
                if array.contains(x) {
                    
                } else {
                    getExerciseFromHere.append(x)
                }
            }
            
        } else if targetArea == "RS" {
            let allRS = self.allRS()
            for x in allRS {
                if array.contains(x) {
                    
                } else {
                    getExerciseFromHere.append(x)
                }
            }
        } else {
            let allFN = self.allFN()
            for x in allFN {
                if array.contains(x) {
                    
                } else {
                    getExerciseFromHere.append(x)
                }
            }
        }
        
        
        while array.contains(nonDuplicate) {
            
            let randomNumb = Int.random(in: 0...(toGetArray.count - 1))
//            nonDuplicate = getExercise(inArray: toGetArray, withArea: targetArea)
            nonDuplicate = toGetArray[randomNumb]
        }
        
        
        return nonDuplicate
    }
    
    private func removeExerciseWith(time: Int, array: [ExerciseObject]) -> [ExerciseObject] {
        var arrayHere = array
        var removed = 0
        var count = arrayHere.count
        for x in 0...(count - 1) {
            
            if removed == 0 && arrayHere[x].duration == time {
                arrayHere.remove(at: x)
                removed = 1
                count = count - 1
            }
        }
        return arrayHere
    }
    
    private func getExerciseWithTime(time: Int, array: [ExerciseObject], area: String, toAddArray: [ExerciseObject]) -> ExerciseObject {
        
        
        var exercise = getExercise(inArray: array, withArea: area)
        while exercise.duration != time || toAddArray.contains(exercise) {
            exercise = getExercise(inArray: array, withArea: area)
        }
        
        return exercise
        
    }
    
    

    
    private func getExercise(inArray: [ExerciseObject], withArea: String) -> ExerciseObject {
        
        var exerciseToReturn: ExerciseObject = allExercises.searchExercises(forThis: "Heel Squat")
        
        let countArray = inArray.count
        let index = Int.random(in: 0 ..< countArray)
        if withArea == "APT" {
            if inArray[index].anteriorPelvicTilt {
                exerciseToReturn = inArray[index]
            } else {
               exerciseToReturn = getExercise(inArray: inArray, withArea: "APT")
            }
        } else if withArea == "RS" {
            if inArray[index].roundedShoulders {
                exerciseToReturn = inArray[index]
            } else {
               exerciseToReturn = getExercise(inArray: inArray, withArea: "RS")
            }
        } else {
            if inArray[index].forwardNeck {
                exerciseToReturn = inArray[index]
            } else {
               exerciseToReturn = getExercise(inArray: inArray, withArea: "FN")
            }
        }
        
        return exerciseToReturn
    }
    
    
    private func setupGenerateButton() {
        

       view.addSubview(generateButton)
        
        if screenHeightGen > 850 {
            view.addConstraintsWithFormat(format: "V:[v0(43)]-83-|", views: generateButton)
        } else if screenHeightGen > 800 {
        view.addConstraintsWithFormat(format: "V:[v0(43)]-80-|", views: generateButton)
        } else if screenHeightGen > 600 {
            view.addConstraintsWithFormat(format: "V:[v0(38)]-49-|", views: generateButton)
        } else {
            view.addConstraintsWithFormat(format: "V:[v0(30)]-49-|", views: generateButton)
        }
        
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: generateButton)
        
    }
    
    let minutesInvestedLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Minutes Invested"
        label.numberOfLines = 2
        label.font = UIFont(name: "GujaratiSangamMN", size: 25)
//        label.font = UIFont(name: "GillSans-Light", size: 30)
        
        return label
    }()
    
    let minutesLabel: UILabel = {
        
        let label = UILabel()
        label.text = "17"
        

        label.font = UIFont(name: "Avenir-LightOblique", size: 70)
       return label
    }()
    
    

//    NEW CV CODE
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        UIView.animate(withDuration: 0.75, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        }, completion: nil)
        
        
        
        currentScreenIndex = menuIndex
        
        if indexPath.item == 0 {
            
            generateButton.setTitle("Begin", for: .normal)
            
        } else if indexPath.item == 1 {
            generateButton.setTitle("Generate", for: .normal)
            
        } else {
            generateButton.setTitle("Begin", for: .normal)
            
        }
        
//        if indexPath.item == 1 {
//            generateButton.setTitle("Personalize", for: .normal)
//
//        } else {
//            generateButton.setTitle("Begin", for: .normal)
//        }
        
        
    }
    

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 3
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuBar.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        currentScreenIndex = Int(index)
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        if indexPath.item == 1 {
            
            generateButton.setTitle("Generate", for: .normal)
        } else {
            
            generateButton.setTitle("Begin Workout", for: .normal)
        }
        
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var ID: String = "morningNightCell"
        var toUseArray: [ExerciseObject] = []
        
        if indexPath.item == 0 {
            ID = "morningNightCell"
            toUseArray = self.morningRoutineArray
        } else if indexPath.item == 1 {
            ID = "selectorID"
        } else {
            ID = "morningNightCell"
            toUseArray = self.nightRoutineArray
        }
        
//        DO MORNING OR NIGHT ARRAY HERE SO THAT IT CAN CHANGE
        
        
        if ID == "selectorID" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectorID", for: indexPath) as! generateCellCV
            cell.backgroundColor = UIColor.white
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! morningNightCell
            cell.backgroundColor = UIColor.white
            cell.fillingArray = toUseArray
            return cell
        }
        
        

    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if screenHeightGen > 850 {
            
            return CGSize(width: view.frame.width, height: view.frame.height - 40 - 43 - 88)
            
        } else if screenHeightGen > 800  {
            
//            was 80
            return CGSize(width: view.frame.width, height: view.frame.height - 40 - 43 - 80)
            
        } else if screenHeightGen > 700 {
            
            return CGSize(width: view.frame.width, height: view.frame.height - 68 - 60 )
            
        } else if screenWidthGen > 400 {
        
        return CGSize(width: view.frame.width, height: view.frame.height - 40 - 40 - 60 )
        
        } else {
//            was 40
            return CGSize(width: view.frame.width, height: view.frame.height - 40 - 40 - 50 )
            
        }
        
        
    }
    
    //    NEW CV CODE END
    
    func saveExercises() {
        do {
            
            try PersistenceService.contextReal.save()
            
        } catch {
            
            print("Error saving context")
            
        }
    }
    
    
    
    func allAPT() -> [ExerciseObject] {
        
        var allAPT: [ExerciseObject] = []
        for element in allExercises.array {
            if element.anteriorPelvicTilt == true {
                allAPT.append(element)
            }
        }
        return allAPT
    }
    
    func allFN() -> [ExerciseObject] {
        
        var allFN: [ExerciseObject] = []
        for element in allExercises.array {
            if element.forwardNeck == true {
                allFN.append(element)
            }
        }
        return allFN
    }
    
    func allRS() -> [ExerciseObject] {
        
        var allRS: [ExerciseObject] = []
        for element in allExercises.array {
            if element.roundedShoulders == true {
                allRS.append(element)
            }
        }
        return allRS
    }
    
    
}
