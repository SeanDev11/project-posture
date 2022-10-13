//
//  FullRes+CoreDataProperties.swift
//  SavingLoadingImages
//
//  Created by Sean Devine on 19.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
//

import Foundation
import CoreData


extension FullRes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FullRes> {
        return NSFetchRequest<FullRes>(entityName: "FullRes")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var thumbnail: Thumbnail?

}
