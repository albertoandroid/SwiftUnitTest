//
//  AddTest.swift
//  UnitTestSwiftCourseTests
//
//  Created by Alberto Palomar Robledo on 16/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

import Foundation
import XCTest
import Mockingbird
@testable import UnitTestSwiftCourse

class AddTest: XCTestCase {
    var sut: Add?
    let mockValidNumber: ValidNumberMock = mock(ValidNumber.self)
    
    override func setUp() {
        sut = Add(validNumber: mockValidNumber)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testAdd(){
        sut?.add(a: 3, b: 4)
        verify(mockValidNumber.check(number: 3)).wasCalled()
    }
    
    
    
}
