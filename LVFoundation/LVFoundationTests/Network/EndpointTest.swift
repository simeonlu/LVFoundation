//
//  EndpointTest.swift
//
//  Created by Shimin lyu on 22/1/2021.
//

import XCTest
@testable import LVFoundation

class EndpointTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndpointUrl() throws {
        // Given an endpoint
        let endpoint = APIEndpoint(host: APIEndpoint.defaultHost, path: "/" + .empty)
        
        // When
        let url = endpoint.url
        
        // Then
        XCTAssertEqual(
            url.absoluteString,
            "https://www.google.com/"
        )
    }
    
    func testLocationsEndpointUrl() throws {
        // Given an endpoint
        let endpoint = APIEndpoint.locations
    
        // When
        let url = endpoint.url
        
        // Then
        XCTAssertEqual(
            url.absoluteString,
            "https://www.google.com/locations"
        )
    }
    
    func testLocationsEndpointUrlWithParams() throws {
        // Given an endpoint
        var endpoint = APIEndpoint.locations
        endpoint.parameters = [
            URLQueryItem(name: "type", value: "restaurant"),
            URLQueryItem(name: "radius", value: "6500")
        ]
        
        // When
        let url = endpoint.url
        
        // Then
        XCTAssertEqual(
            url.absoluteString,
            "https://www.google.com/locations?type=restaurant&radius=6500"
        )
    }
    
    func testLocationsEndpointUrlRequestMethod() throws {
        // Given an endpoint
        let request = APIEndpoint.locations.makeRequest()
        
        // Then
        XCTAssertEqual(
            request.httpMethod,
            "GET"
        )
    }

}

extension APIEndpoint {

    static var defaultHost: String {
        return "www.google.com"
    }
    
    static let locations = APIEndpoint(host: defaultHost, path: "/locations")
}
