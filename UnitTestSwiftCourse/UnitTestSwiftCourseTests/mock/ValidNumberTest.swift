//
//  ValidNumberTest.swift
//  UnitTestSwiftCourseTests
//
//  Created by Alberto Palomar Robledo on 16/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

import Foundation
import XCTest
@testable import UnitTestSwiftCourse

class ValidNumberTest: XCTestCase {
    var sut: ValidNumber?
    
    override func setUp() {
        sut = ValidNumber()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testCheck(){
        XCTAssertEqual(true, sut?.check(number: 4))
    }
    
    func testCheckNegative(){
        XCTAssertEqual(false, sut?.check(number: -4))
    }
    
    func testCheckMoreThan10(){
        XCTAssertEqual(false, sut?.check(number: 10))
    }
}
