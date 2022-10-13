//
//  Thumbnail+CoreDataProperties.swift
//  
//
//  Created by Sean Devine on 20.10.19.
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
    @NSManaged public var workoutNumber: Int16
}
