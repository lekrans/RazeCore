//
//  RazeNetworkingTests.swift
//  RazeCoreTests
//
//  Created by Michael Lekrans on 2021-11-23.
//

import XCTest
@testable import RazeCore

final class RazeNetworkingTests: XCTestCase {

    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        let expectation = XCTestExpectation(description: "Called for data")
        guard let url = URL(string: "https://raywenderlich.com") else {
            return XCTFail("Could not create URL property")
        }
        
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertNotNil(returnedData, "Response data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        wait(for : [expectation], timeout: 5)
    }
}