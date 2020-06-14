//
//  StringManagerTest.swift
//  UnitTestSwiftCourseTests
//
//  Created by Alberto Palomar Robledo on 14/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

import Foundation

import XCTest
@testable import UnitTestSwiftCourse

class StringManagerTest: XCTestCase {
    var sut: StringManager?
    
    override func setUp() {
        sut = StringManager()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testToUpperCased(){
        XCTAssertEqual("ESTOY HACIENDO UN UNIT TEST", sut?.toUpperCased(message: "estoy HACIENDO un UNIT test"))
    }
    
    func testToLowerCased(){
        XCTAssertEqual("estoy haciendo un unit test", sut?.toLowerCased(message: "Estoy haciendo un UNIT TEST"))
    }
}
