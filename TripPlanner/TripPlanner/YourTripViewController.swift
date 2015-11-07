//
//  YourTripViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/30/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class YourTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tripTableView: UITableView!
    var waypoints: [Waypoint] = []
    var coreDataStack = CoreDataStack(stackType: .SQLite)
    var placeID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "waypointcell")
        self.waypoints = CoreDataClient(managedObjectContext: self.coreDataStack.managedObjectContext).allWaypoints()
        self.tripTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.waypoints = CoreDataClient(managedObjectContext: self.coreDataStack.managedObjectContext).allWaypoints()
        self.tripTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.waypoints.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tripTableView.dequeueReusableCellWithIdentifier("waypointcell")! as UITableViewCell
        cell.textLabel?.text = self.waypoints[indexPath.row].name
        self.placeID = self.waypoints[indexPath.row].placeID
        
        return cell
    }
    
    //Segue definition and passing the variable to next viewcontroller
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      performSegueWithIdentifier("segueToShowWayPoint", sender: placeID)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToShowWayPoint" {
            let wayPointInfoViewController = segue.destinationViewController as! WayPointInfoViewController
            let placeID = sender as! String
            wayPointInfoViewController.placeID = placeID
        }
    }
    
    //Sliding the cell to delete
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            do {
                CoreDataClient(managedObjectContext: self.coreDataStack.managedObjectContext).deleteWaypoints(indexPath)
                self.waypoints = CoreDataClient(managedObjectContext: self.coreDataStack.managedObjectContext).allWaypoints()
                self.tripTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    
}

