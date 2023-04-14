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
    public var displayedMarkers: [MapMarker] = []
    private let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchData(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D, completion: @escaping (Result<[MapElement], Error>) -> Void) {
        apiManager.getResources(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon, completion: completion)
    }
    

}
