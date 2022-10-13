//
//  ExerciseObject.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 10.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

public class ExerciseObject: NSObject {
    
    
    let name: String
    let duration: Int16
    var videoLink: String? = ""
    let anteriorPelvicTilt: Bool
    let forwardNeck: Bool
    let roundedShoulders: Bool
    let noEquipment: Bool
    let pullUp: Bool
    let resistanceBand: Bool
    let broomstick: Bool
    let switchSides: Bool
    var topTips: String
    let videoThumbnail: String
    
    init(name: String, duration: Int, anteriorPelvicTilt: Bool, forwardNeck: Bool, roundedShoulders: Bool, noEquipment: Bool, pullUp: Bool, resistanceBand: Bool, broomstick: Bool, switchSides: Bool, topTips: String, videoThumbnail: String) {
        
        self.name = name
        self.duration = Int16(duration)
        
        self.anteriorPelvicTilt = anteriorPelvicTilt
        self.forwardNeck = forwardNeck
        self.roundedShoulders = roundedShoulders
        self.noEquipment = noEquipment
        self.pullUp = pullUp
        self.resistanceBand = resistanceBand
        self.broomstick = broomstick
        self.switchSides = switchSides
        self.topTips = topTips
        self.videoThumbnail = videoThumbnail
    }
    
    
    
    
    
}
