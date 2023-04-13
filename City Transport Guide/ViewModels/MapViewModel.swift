//
//  MapViewModel.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 13/4/23.
//

import Foundation
import CoreLocation
import GoogleMaps

class MapViewModel {
    private var displayedMarkers: [MapMarker] = []
    
    func getResources(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D, completion: @escaping (Result<[MapElement], Error>) -> Void) {
        APIManager.shared.getResources(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon, completion: completion)
    }
    
    func updateDisplayedMarkers(mapView: GMSMapView) {
        displayedMarkers = displayedMarkers.filter { marker in
            if !mapView.projection.contains(marker.position) {
                marker.map = nil
                return false
            }
            return true
        }
    }
    func addMarkerWithAnimation(mapElement: MapElement, mapView: GMSMapView) {
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.75)
            
            let markerPosition = CLLocationCoordinate2D(latitude: mapElement.y, longitude: mapElement.x)
            
            if !self.displayedMarkers.contains(where: { $0.mapElement.id == mapElement.id }) {
                let marker = MapMarker(mapElement: mapElement)
                marker.opacity = 0 // Set initial opacity to 0
                marker.map = mapView
                
                // Animate the marker opacity to 1 (fade-in effect)
                CATransaction.setCompletionBlock {
                    marker.opacity = 1
                }
                
                self.displayedMarkers.append(marker)
            }
            
            CATransaction.commit()
        }
    }
}
