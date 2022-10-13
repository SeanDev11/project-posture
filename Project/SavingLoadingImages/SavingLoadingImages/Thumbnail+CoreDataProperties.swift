//
//  Thumbnail+CoreDataProperties.swift
//  SavingLoadingImages
//
//  Created by Sean Devine on 19.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
//

import Foundation
import CoreData


extension Thumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest<Thumbnail>(entityName: "Thumbnail")
    }

    @NSManaged public var id: Double
    @NSManaged public var imageData: NSData?
    @NSManaged public var fullRes: FullRes?

}
