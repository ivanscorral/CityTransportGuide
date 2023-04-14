//
//  InitialViewModelTests.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 14/4/23.
//

import XCTest

import XCTest
@testable import City_Transport_Guide

class InitialViewModelTests: XCTestCase {
    var viewModel: InitialViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = InitialViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test Case: Check if fetchImage function returns a non-nil URL.
    // Expected Result: The imageURL should not be nil.
    func testFetchImage() {
        let expectation = self.expectation(description: "FetchImage")
        viewModel.fetchImage { result in
            switch result {
            case .success(let url):
                XCTAssertNotNil(url, "URL should not be nil")
            case .failure(let error):
                XCTFail("Error fetching image: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchImagePerformance() throws {
          measure {
              let expectation = self.expectation(description: "Fetch image from API")

              viewModel.fetchImage { result in
                  switch result {
                  case .success(_):
                      expectation.fulfill()
                  case .failure(let error):
                      XCTFail("Error loading image: \(error)")
                  }
              }
              waitForExpectations(timeout: 10, handler: nil)
          }
      }
    
}
