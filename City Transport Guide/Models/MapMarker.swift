//
//  MapMarker.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

import Foundation
import GoogleMaps

class MapMarker: GMSMarker {
    let mapElement: MapElement
    
    init(mapElement: MapElement) {
        self.mapElement = mapElement
        super.init()
        position = CLLocationCoordinate2D(latitude: mapElement.y, longitude: mapElement.x)
    }
}
