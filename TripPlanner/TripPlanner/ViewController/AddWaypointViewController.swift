//
//  AddWaypointViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/30/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//
import UIKit
import Foundation
import GoogleMaps

class AddWaypointViewController: UIViewController {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    var placesClient: GMSPlacesClient?
    @IBOutlet weak var waypointSearchBar: UISearchBar!
    @IBOutlet weak var waypointTableView: UITableView!
    var prediction: [GMSAutocompletePrediction?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waypointSearchBar.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        placesClient = GMSPlacesClient()
        self.waypointTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "addWaypointCell")
    }
    
    func placeAutocomplete(searchtext: String) {
        self.prediction = []
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.Region
        placesClient?.autocompleteQuery(searchtext, bounds: nil, filter: filter, callback: { (results, error: NSError?) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
            }
           
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.prediction.append(result)
//                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                }
            }
            self.waypointTableView.reloadData()
        })
        
    }
    
    
}

 //MARK: TablveViewDelegat/DataSource
extension AddWaypointViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prediction.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let regularFont = UIFont.systemFontOfSize(UIFont.labelFontSize())
        let boldFont = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        
        let bolded = prediction[indexPath.row]!.attributedFullText as! NSMutableAttributedString
        bolded.enumerateAttribute(kGMSAutocompleteMatchAttribute, inRange: NSMakeRange(0, bolded.length), options: []) { (value, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            let font = (value == nil) ? regularFont : boldFont
            bolded.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        
        let cell = self.waypointTableView.dequeueReusableCellWithIdentifier("addWaypointCell")! as UITableViewCell
        cell.textLabel?.attributedText = bolded
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("hohoho")
    }
}



//MARK: SearchBar Delegate
extension AddWaypointViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        waypointSearchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
        placeAutocomplete(searchText)
        }
        self.waypointTableView.reloadData()
    }
}


// MARK: - CLLocationManagerDelegate
//1
extension AddWaypointViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
}
