//
//  MapViewModelTests.swift
//  City Transport Guide Tests
//
//  Created by Ivan Sanchez on 14/4/23.
//

import XCTest
import CoreLocation
@testable import City_Transport_Guide

class MapViewModelTests: XCTestCase {
    var mapViewModel: MapViewModel!

    override func setUp() {
        super.setUp()
        mapViewModel = MapViewModel()
    }

    override func tearDown() {
        mapViewModel = nil
        super.tearDown()
    }

    func testFetchData() {
        let expect = expectation(description: "fetchData completes")
        let lowerLeftLatLon = CLLocationCoordinate2D(latitude: 38.711046, longitude: -9.160096)
        let upperRightLatLon = CLLocationCoordinate2D(latitude: 38.739429, longitude: -9.137115)

        mapViewModel.fetchData(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon) { result in
            switch result {
            case .success(let mapElements):
                XCTAssert(!mapElements.isEmpty, "Map elements should not be empty")
            case .failure(let error):
                XCTFail("Fetch data failed with error: \(error)")
            }
            expect.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
    func testFetchDataWithEmptyMapElements() {
        let expectation = XCTestExpectation(description: "Fetch data with empty map elements")
        
        let mockAPIManager = MockAPIManager()
        mockAPIManager.result = .success([])
        
        let mapViewModel = MapViewModel(apiManager: mockAPIManager)
        mapViewModel.fetchData(lowerLeftLatLon: CLLocationCoordinate2D(latitude: 0, longitude: 0), upperRightLatLon: CLLocationCoordinate2D(latitude: 1, longitude: 1)) { result in
            switch result {
            case .success(let mapElements):
                XCTAssertTrue(mapElements.isEmpty)
            case .failure:
                XCTFail("Should not return an error")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

