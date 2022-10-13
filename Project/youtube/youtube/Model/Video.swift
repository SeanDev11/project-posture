//
//  Video.swift
//  youtube
//  Created by Sean Devine on 09.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
import Foundation
import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    
    var channel: Channel?
    
    var numOfViews: NSNumber?
    var uploadDate: NSDate?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
    
}
