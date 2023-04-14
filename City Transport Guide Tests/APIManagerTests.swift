//
//  APIManagerTests.swift
//  City Transport Guide Tests
//
//  Created by Ivan Sanchez on 14/4/23.
//

import XCTest
import CoreLocation

@testable import City_Transport_Guide

class ApiManagerTests: XCTestCase {
    var apiManager: APIManager!

    override func setUp() {
        super.setUp()
        apiManager = APIManager.shared
    }

    override func tearDown() {
        apiManager = nil
        super.tearDown()
    }
    

    func testGetResources() {
        // This test case checks if the getResources function returns valid data.
        let expectation = self.expectation(description: "Fetch resources from API")

        let lowerLeftLatLon = CLLocationCoordinate2D(latitude: 38.711046, longitude: -9.160096)
        let upperRightLatLon = CLLocationCoordinate2D(latitude: 38.739429, longitude: -9.137115)

        apiManager.getResources(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon) { result in
            switch result {
            case .success(let mapElements):
                XCTAssertFalse(mapElements.isEmpty, "Resources should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("API Error: \(error)")
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
