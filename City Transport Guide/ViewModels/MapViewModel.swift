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
    private let mapModel = MapModel()
    private var displayedMarkers: [MapMarker] = []
    
    func fetchData(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D, completion: @escaping (Result<[MapElement], Error>) -> Void) {
        mapModel.getResources(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon, completion: completion)
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
            //Animate markers showing to add smoothness to the transitions
            CATransaction.begin()
            CATransaction.setAnimationDuration(1.35)
                        
            if !self.displayedMarkers.contains(where: { $0.mapElement.id == mapElement.id }) {
                let marker = MapMarker(mapElement: mapElement)
                marker.icon = mapElement.markerImage
                marker.opacity = 0 // Set initial opacity to 0
                marker.map = mapView
                // Set the snippet for the marker
                var snippetText = mapElement.markerDescription
                let regexPattern = "\\d+:M\\d+"
                
                // Check the regex on the mapElement Id to identify metro stations
                
                if let _ = mapElement.id.range(of: regexPattern, options: .regularExpression) {
                    // Set the appropiate line break text depending on snippetText's content
                    snippetText = snippetText != "" ? "Estación de Metro\n\(snippetText)" : "Estación de Metro"
                }
                // Set the title (computed variable)
                marker.title = mapElement.markerTitle
                // Set our modified snippet or description
                marker.snippet = snippetText
                
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
