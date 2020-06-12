//
//  TemperatureCalculatorTest.swift
//  UnitTestSwiftCourseTests
//
//  Created by Alberto Palomar Robledo on 12/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

import Foundation

import XCTest
@testable import UnitTestSwiftCourse

class TemperatureCalculatorTest: XCTestCase {
    var sut: TemperatureCalculator?
    
    override func setUp() {
        sut = TemperatureCalculator()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testToFahrenheit(){
        let expectedResult: Double = -9.4
        let result = sut?.toFahrenheit(degree: -23)
        
        XCTAssertEqual(expectedResult, result)
    }
}
