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
    
}

