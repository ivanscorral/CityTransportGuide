//
//  MockAPIManager.swift
//  City Transport Guide Tests
//
//  Created by Ivan Sanchez on 14/4/23.
//
import Foundation
import CoreLocation

@testable import City_Transport_Guide

class MockAPIManager: APIManagerProtocol {
    var result: Result<[MapElement], Error>?
    
    func getResources(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D, completion: @escaping (Result<[MapElement], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
