//
//  AddWaypointViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/30/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//
import UIKit
import Foundation

class AddWaypointViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var waypointTableView: UITableView!
    var items: [String] = ["Dummy data1", "Dummy data2", "Dummy data3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.waypointTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "addWaypointCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.waypointTableView.dequeueReusableCellWithIdentifier("addWaypointCell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("hohoho")
    }
    
}
