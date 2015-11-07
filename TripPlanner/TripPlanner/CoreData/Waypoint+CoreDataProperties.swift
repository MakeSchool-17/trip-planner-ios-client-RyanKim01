//
//  Waypoint+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Ryan Kim on 11/2/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Waypoint {

    @NSManaged var latitude: NSNumber?
    @NSManaged var address: String?
    @NSManaged var placeID: String?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var trip: NSManagedObject?

}
