//
//  TripViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/29/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tripTableView: UITableView!
    var waypoints: Bool = true
    var trips: [Trip] = []
    var coreDataStack = CoreDataStack(stackType: .SQLite)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tripcell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        trips = CoreDataClient(managedObjectContext: coreDataStack.managedObjectContext).allTrips()
        tripTableView.reloadData()
    }
    
    @IBAction func pressedAddButton(sender: AnyObject) {
        let alert = UIAlertController(title: "New Trip", message: "Add a new trip", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveName(textField!.text!)
            self.trips = CoreDataClient(managedObjectContext: self.coreDataStack.managedObjectContext).allTrips()
            self.tripTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func saveName(name: String) {
        do {
            try CoreDataClient(managedObjectContext: coreDataStack.managedObjectContext).saveTrips(name)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    //MARK: TablveViewDelegate/DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return trips.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tripTableView.dequeueReusableCellWithIdentifier("tripcell")! as UITableViewCell
        cell.textLabel?.text = self.trips[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if waypoints == true {
            performSegueWithIdentifier("segueToWaypoint", sender: nil)
        } else {
            performSegueWithIdentifier("segueToNoWaypoint", sender: nil)
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
                CoreDataClient(managedObjectContext: self.coreDataStack.managedObjectContext).deleteTrips(indexPath)
                self.trips = CoreDataClient(managedObjectContext: self.coreDataStack.managedObjectContext).allTrips()
                self.tripTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
}

