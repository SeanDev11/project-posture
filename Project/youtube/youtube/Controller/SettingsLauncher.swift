//
//  SettingsLauncher.swift
//  youtube
//
//  Created by Sean Devine on 28.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit


class Setting: NSObject {
    
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    
    case Settings = "Settings"
    case TermsPrivacy = "Terms & Privacy Policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel"
    
    case badSetting = "badSetting"
}



class SettingsLauncher:  NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    
    }()
    
    let cellId = "cellId"
    
    let cellHeight: CGFloat = 50
    
    var homeController: HomeController?
    
    
    let settings: [Setting] = {
        
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        
        
        
        
        return [ settingsSetting, Setting(name: .TermsPrivacy, imageName: "privacy"), Setting(name: .SendFeedback, imageName: "feedback"), Setting(name: .Help, imageName: "help"), Setting(name: .SwitchAccount, imageName: "switch_account"), cancelSetting]
        
    }()
    
    
    @objc func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlackViewTap)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = (CGFloat(settings.count) * cellHeight)
            let y = window.frame.height - height

            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.height, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            )
            
            
            
        }
    }
    
    @objc func handleBlackViewTap() {
        let badSetting = Setting(name: .badSetting, imageName: "bad")
        handleDismiss(setting: badSetting)
    }
    
    @objc func handleDismiss(setting: Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
            
        }) { (completed: Bool) in
            
            
            if setting.name != .Cancel && setting.name != .badSetting {
                self.homeController?.showControllerForSetting(setting: setting)
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return settings.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
        
    }
    
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register( SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
