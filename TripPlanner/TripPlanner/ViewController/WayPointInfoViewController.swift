//
//  WayPointInfoViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/30/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps

class WayPointInfoViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var waypointLabel: UILabel!
    @IBOutlet weak var mapview: GMSMapView!
    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient?
    var placeID: String!
    var place: GMSPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient()
        searchBar.delegate = self
        findThePlace(placeID)
    }
    
    func findThePlace(placeID: String) {
        placesClient!.lookUpPlaceID(placeID, callback: { (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                print("Place name \(place.name)")
                print("Place address \(place.formattedAddress)")
                print("Place placeID \(place.placeID)")
                print("Place attributions \(place.attributions)")
                self.place = place
                
                var marker = GMSMarker()
                marker.position = place.coordinate
                marker.title = place.name
                marker.map = self.mapview
                
                self.mapview.animateToLocation(marker.position)
                
            } else {
                print("No place details for \(self.placeID)")
            }
        })
    }
}


extension WayPointInfoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - CLLocationManagerDelegate
extension WayPointInfoViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            if let mapview = mapview {
                mapview.myLocationEnabled = true
                mapview.settings.myLocationButton = true
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapview.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
    }
}

