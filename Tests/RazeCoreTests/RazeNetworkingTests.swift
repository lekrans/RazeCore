//
//  RazeNetworkingTests.swift
//  RazeCoreTests
//
//  Created by Michael Lekrans on 2021-11-23.
//

import XCTest
@testable import RazeCore

final class RazeNetworkingTests: XCTestCase {
    
    class NetworkSessionMock: NetworkSession {
        func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
            completionHandler(data, error)
        }
        
        var data: Data?
        var error: Error?
        
        
    }

    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        let expectation = XCTestExpectation(description: "Called for data")
        let data = Data([0, 1, 0, 1])
        session.data = data
        let url = URL(fileURLWithPath: "url")
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertEqual(data, returnedData, "Manager returned unexpected data")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        wait(for : [expectation], timeout: 5)
    }
}
