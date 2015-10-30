//
//  TripViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/29/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//

import Foundation
import UIKit

class TripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tripTableView: UITableView!
    var items: [String] = ["Los Angeles", "San Francisco", "Oregon"]
    var waypoints: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tripcell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tripTableView.dequeueReusableCellWithIdentifier("tripcell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if waypoints == true {
            performSegueWithIdentifier("segueToWaypoint", sender: nil)
        } else {
            performSegueWithIdentifier("segueToNoWaypoint", sender: nil)
        }
        
    }
    
}

