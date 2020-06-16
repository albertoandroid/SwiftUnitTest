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
    let mockPrint: PrintMock = mock(Print.self)
    
    override func setUp() {
        sut = Add(validNumber: mockValidNumber, print: mockPrint)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testAdd(){
        given(mockValidNumber.check(number: 3)) ~> true
        given(mockValidNumber.check(number: 4)) ~> true
        sut?.add(a: 3, b: 4)
        verify(mockValidNumber.check(number: 3)).wasCalled()
        verify(mockValidNumber.check(number: 4)).wasCalled()
    }
    
    func testAdd2(){
        given(mockValidNumber.check(number: any())) ~> true
        var checkNumber: Bool = mockValidNumber.check(number: 3)
        XCTAssertEqual(true, checkNumber)
        
        given(mockValidNumber.check(number: -3)) ~> false
        checkNumber = mockValidNumber.check(number: -3)
        XCTAssertEqual(false, checkNumber)
    }
    
    /*
     AAA
     Arrange
     Act
     Assert
     
     GWT
     Given
     When
     Then
     */
    
    func testAAAPattern(){
        //Arrange
        given(mockValidNumber.check(number: 3)) ~> true
        given(mockValidNumber.check(number: 4)) ~> true
        //Act
        let result = sut?.add(a: 3, b: 4)
        //Assert
        XCTAssertEqual(7, result)
    }
    
    func testBDDPattern(){
        //Given
        given(mockValidNumber.check(number: 3)) ~> true
        given(mockValidNumber.check(number: 4)) ~> true
        //When
        let result = sut?.add(a: 3, b: 4)
        //Then
        XCTAssertEqual(7, result)
    }
    
    func testArgumentMatcher(){
        //Given
        given(mockValidNumber.check(number: any())) ~> true
        //When
        let result = sut?.add(a: 3, b: 4)
        //Then
        XCTAssertEqual(7, result)
    }
    
    func testAddPrint(){
        //Given
        given(mockValidNumber.check(number: any())) ~> true
        //When
        sut?.addPrint(a: 3, b: 4)
        //Then
        //XCTAssertEqual(7, result)
    }
    
    
    
}
