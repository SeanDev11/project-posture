//
//  Favorite+CoreDataProperties.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 10.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var anteriorPelvicTilt: Bool
    @NSManaged public var duration: Int16
    @NSManaged public var forwardNeck: Bool
    @NSManaged public var name: String?
    @NSManaged public var noEquipment: Bool
    @NSManaged public var pullUp: Bool
    @NSManaged public var resistanceBand: Bool
    @NSManaged public var roundedShoulders: Bool
    @NSManaged public var workoutArray: [NSString]

}
