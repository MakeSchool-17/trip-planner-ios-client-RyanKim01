//
//  PlaceMarker.swift
//  TripPlanner
//
//  Created by Ryan Kim on 11/6/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//

import GoogleMaps
import UIKit
import Foundation


class PlaceMarker: GMSMarker {
    let place: GMSPlace
    
    // 2
    init(place: GMSPlace) {
        self.place = place
        super.init()
        
        position = place.coordinate
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
