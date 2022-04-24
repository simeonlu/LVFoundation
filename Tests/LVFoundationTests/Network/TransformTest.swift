//
//  TransformTest.swift
//  
//
//  Created by Shimin lyu on 24/4/2022.
//

import XCTest
import LVFoundation

class TransformTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGeneralJsonTransformer() {
        //Given
        let data =
        """
        {"name": "Swift","age": 5}
        """
        .data(using: .utf8)!

        let sut = JsonModelTransformer<Person>()
        //When
        let result = try? sut.transform(data, URLResponse())
        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.name, "Swift")
        XCTAssertEqual(result!.age, 5)
    }
    
    func testGeneralJsonTransformerFailure() {
        //Given
        let data =
        """
        {"name": "Swift",}
        """
        .data(using: .utf8)!

        let sut = JsonModelTransformer<Person>()
        //When
        do {
            try _ = sut.transform(data, URLResponse())
        } catch( let error) {
            //Then
            if case let NetworkError.decode(description) = error {
                //Then
                XCTAssertNotNil(description)
            } else {
                XCTAssertFalse(true)
            }
        }
    }
}

private struct Person: Decodable {
    let name: String
    let age: Int
}
