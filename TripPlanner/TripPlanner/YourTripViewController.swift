//
//  YourTripViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/30/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//

import Foundation
import UIKit

class YourTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tripTableView: UITableView!
    var items: [String] = ["Westwood", "Culver City", "Brentwood"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "waypointcell")
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
      print("oh yeah")
        
    }
    
}

