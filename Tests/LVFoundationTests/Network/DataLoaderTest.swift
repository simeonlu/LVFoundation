//
//  DataLoaderTest.swift
//
//  Created by Shimin lyu on 23/1/2021.
//

import XCTest
import Combine
@testable import LVFoundation

class DataLoaderTest: XCTestCase {
    typealias ResponseTuple = URLSession.DataTaskPublisher.Output
    var cancellable: Set<AnyCancellable>!
    override func setUpWithError() throws {
        cancellable = .init()
    }
    
    override func tearDownWithError() throws {
        cancellable = nil
    }
    
    func testFilterSuccessfulStatusCodes() throws {
        
        // Given a response result
        let expect = expectation(description: #function)
        let data = Data()
        let response = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        let result = ResponseTuple(data: data, response: response!)
        let publisher = Just(result)
        
        // When filter status code
        _ = publisher
            .filterSuccessfulStatusCodes()
            .sink(receiveCompletion: { completion in
                // Then
                guard case .finished = completion else {
                    XCTFail("Expected a successful status")
                    return
                }
                expect.fulfill()
                
            }, receiveValue: { _ in })
        
        wait(for: [expect], timeout: 0.5)
    }
    
    func testFilterSuccessfulStatusCodesErrorOnResponse() throws {
        
        // Given a response result
        let expect = expectation(description: #function)
        let data = Data()
        let response = URLResponse()
        let result = ResponseTuple(data: data, response: response)
        let publisher = Just(result)
        
        // When filter status code
        publisher
            .filterSuccessfulStatusCodes()
            .sink(receiveCompletion: { completion in
                // Then
                
                guard case let .failure(error) = completion else {
                    XCTFail("Expected a failure")
                    return
                }
                guard let networkErr = error as? NetworkError else {
                    XCTFail("Expected a NetworkError")
                    return
                }
                XCTAssertEqual(networkErr, NetworkError.httpError)
                expect.fulfill()
                
            }, receiveValue: { _ in })
            .store(in: &cancellable)
        
        wait(for: [expect], timeout: 1)
    }
    
    func testFilterSuccessfulStatusCodesUnknown() throws {
        
        // Given a response result
        let expect = expectation(description: #function)
        let data = Data()
        let response = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 403, httpVersion: nil, headerFields: [:])
        let result = ResponseTuple(data: data, response: response!)
        let publisher = Just(result)
        
        // When filter status code
        _ = publisher
            .filterSuccessfulStatusCodes()
            .sink(receiveCompletion: { completion in
                // Then
                guard case let .failure(error) = completion else {
                    XCTFail("Expected a failure")
                    return
                }
                guard let networkErr = error as? NetworkError else {
                    XCTFail("Expected a NetworkError")
                    return
                }
                XCTAssertEqual(networkErr, NetworkError.forbidden)
                expect.fulfill()
                
            }, receiveValue: { _ in })
        
        wait(for: [expect], timeout: 1)
    }
    
}
