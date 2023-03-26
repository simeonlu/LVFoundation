//
//  CurrencyTest.swift
//  
//
//  Created by Shimin lyu on 26/3/2023.
//

import XCTest
@testable import LVFoundation

final class CurrencyTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUSD() throws {
        // Given
        let oneDollar = Money<USD>(1.0)
        let threeDollars = Money<USD>(3.2)
        
        //When
        let plus = oneDollar + threeDollars
        
        //Then
        XCTAssertEqual(plus, Money<USD>(4.2))
        
    }

}
