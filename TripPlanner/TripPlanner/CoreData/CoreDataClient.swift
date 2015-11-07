//
//  CoreDataClient.swift
//  NetworkingCoreData
//
//  Created by Benjamin Encz on 10/30/15.
//  Copyright © 2015 Make School. All rights reserved.
//

import Foundation
import CoreData
import GoogleMaps

class CoreDataClient {
  
  var managedObjectContext: NSManagedObjectContext
  
  init(managedObjectContext: NSManagedObjectContext) {
    self.managedObjectContext = managedObjectContext
  }
  
  //MARK: Trips
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
  
    //MARK: Waypoints
    func allWaypoints() -> [Waypoint] {
        let fetchRequest = NSFetchRequest(entityName: "Waypoint")
        let waypoints = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [Waypoint]
        
        return waypoints
    }
    
    func saveWaypoints(place: GMSPlace) -> () {
        let waypoint = NSEntityDescription.insertNewObjectForEntityForName("Waypoint",
            inManagedObjectContext: managedObjectContext) as! Waypoint
        waypoint.name = place.name
        waypoint.latitude = place.coordinate.latitude
        waypoint.longitude = place.coordinate.longitude
        waypoint.address = place.formattedAddress
        waypoint.placeID = place.placeID
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            assertionFailure("Error saving context: \(error), \(error.userInfo)")
        } catch {
            assertionFailure("Undefined error")
        }
    }
    
    func deleteWaypoints(indexPath: NSIndexPath) -> () {
        let fetchRequest = NSFetchRequest(entityName: "Waypoint")
        fetchRequest.returnsObjectsAsFaults = false
        let waypoints = try! managedObjectContext.executeFetchRequest(fetchRequest)
        do {
            try self.managedObjectContext.deleteObject(waypoints[indexPath.row] as! NSManagedObject)
        } catch let error as NSError {
            assertionFailure("Error saving context: \(error), \(error.userInfo)")
        } catch {
            assertionFailure("Undefined error")
        }
    }
    
    
}