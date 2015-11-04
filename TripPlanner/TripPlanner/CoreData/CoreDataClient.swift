//
//  CoreDataClient.swift
//  NetworkingCoreData
//
//  Created by Benjamin Encz on 10/30/15.
//  Copyright © 2015 Make School. All rights reserved.
//

import Foundation
import CoreData

class CoreDataClient {
  
  var managedObjectContext: NSManagedObjectContext
  
  init(managedObjectContext: NSManagedObjectContext) {
    self.managedObjectContext = managedObjectContext
  }
  
  func allTrips() -> [Trip] {
    let fetchRequest = NSFetchRequest(entityName: "Trip")
    let trips = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [Trip]
    
    return trips
  }
    
    func saveTrips(text: String) -> () {
        let trip = NSEntityDescription.insertNewObjectForEntityForName("Trip",
            inManagedObjectContext: managedObjectContext) as! Trip
        trip.name = text
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            assertionFailure("Error saving context: \(error), \(error.userInfo)")
        } catch {
            assertionFailure("Undefined error")
        }
    }
    
    func deleteTrips(indexPath: NSIndexPath) -> () {
        let fetchRequest = NSFetchRequest(entityName: "Trip")
        fetchRequest.returnsObjectsAsFaults = false
        let trips = try! managedObjectContext.executeFetchRequest(fetchRequest)
        do {
            try self.managedObjectContext.deleteObject(trips[indexPath.row] as! NSManagedObject)
        } catch let error as NSError {
            assertionFailure("Error saving context: \(error), \(error.userInfo)")
        } catch {
            assertionFailure("Undefined error")
        }
    }
  
}