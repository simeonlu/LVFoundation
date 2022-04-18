//
//  NetworkErrorTest.swift
//
//  Created by Shimin lyu on 23/1/2021.
//

import XCTest
@testable import LVFoundation

class NetworkErrorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testErrorMapFromStatusCode() throws {
  
        // Given few status codes
        let statusCode0 = -1
        let statusCode403 = 403
        let statusCode = Int.max
        let timeoutCode = NSURLErrorTimedOut
        
        // When mapping
        let error0 = NetworkError.map(statusCode0)
        let error403 = NetworkError.map(statusCode403)
        let error = NetworkError.map(statusCode)
        let timeoutError = NetworkError.map(timeoutCode)
        
        // Then
        XCTAssertEqual(error0, NetworkError.unknown)
        XCTAssertEqual(error403, NetworkError.forbidden)
        XCTAssertEqual(error, NetworkError.unknown)
        XCTAssertEqual(timeoutError, NetworkError.timeout)
        
    }
    
    func testErrorMapFromURLError() throws {
  
        // Given
        let urlError = URLError(.networkConnectionLost)
        let timeout = URLError(.timedOut)
        
        // When mapping
        let error = NetworkError.map(urlError)
        let timeoutError = NetworkError.map(timeout)
        
        // Then
        XCTAssertEqual(error, NetworkError.unknown)
        XCTAssertEqual(timeoutError, NetworkError.timeout)
    }

}
