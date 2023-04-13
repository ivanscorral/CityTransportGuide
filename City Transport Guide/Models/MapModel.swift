//
//  MapModel.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 13/4/23.
//

import Foundation
import CoreLocation

class MapModel {
    func getResources(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D, completion: @escaping (Result<[MapElement], Error>) -> Void) {
        APIManager.shared.getResources(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon, completion: completion)
    }
}
