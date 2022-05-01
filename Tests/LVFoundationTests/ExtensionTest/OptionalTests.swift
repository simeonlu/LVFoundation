//
//  OptionalTests.swift
//  
//
//  Created by Shimin lyu on 1/5/2022.
//

import XCTest
@testable import LVFoundation

class OptionalTests: XCTestCase {

    let value = Optional.some("optional")
    let none = Optional<String>.none
    let error = NSError(domain: "", code: 101, userInfo: nil)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOptionalEmptiness() {

        XCTAssert(value.isSome)
        XCTAssert(none.isNone)

    }

    func testOptionalOr() {

        XCTAssert(value.or("default") != "default")
        XCTAssert(value.or("default") == "optional")
        XCTAssert(none.or("default") == "default")

        XCTAssert(value.or { "else" } == "optional")
        XCTAssert(none.or {"else"} == "else")

        XCTAssertNoThrow(try value.or(throw: error))
        XCTAssertThrowsError(try none.or(throw: error))

    }

    func testOptionalOn() {
        value.on(some: {
            XCTAssertTrue(true)
        })
        none.on(none: {
            XCTAssertTrue(true)
        })
        value.on(none: {
            XCTAssertTrue(false)
        })
        none.on(some: {
            XCTAssertTrue(false)
        })

    }

}
