//
//  CalculatorTests.swift
//  UnitTestSwiftCourseTests
//
//  Created by Alberto Palomar Robledo on 07/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

/*
//METODO/////////////////ESPECIFICACION//////////////////////////////
func sumar(                 |Este método devuelve un int
    numero1: Int,           |
    numero2: Int            |
    ): Int                  | -> Nos devuelve un Entero con el resultado
---------------------------------------------------------------------
func restar(                |Este método devuelve un int r
    numero1: Int,           |
    numero2: Int            |
    ): Int                  |-> Nos devuelve un Entero con el resultado
---------------------------------------------------------------------
 
Método a Probar                 |      Entrada      |       Salida Esperarada
sumar(int a, int b)             |a = 10, b=20       |30
sumar(int a, int b)             |a = 7, b=4         |11
restar(int a, int b)            |a = 7, b=4         |3
restar(int a, int b)            |a = 10, b=20       |-10
*/

import Foundation
import XCTest

@testable import UnitTestSwiftCourse

class CalculatorTests: XCTestCase {
    
    var sut: Calculator!
    
    override func setUp() {
        print("XXXX setUp()")
        sut = Calculator()
    }
    
    override func tearDown() {
        print("XXXX tearDown()")
        sut = nil
    }
    
    func testCalculatorNotNil(){
        print("XXXX testCalculatorNotNil()")
        XCTAssertNotNil(sut, "SUT debería ser not nil en este punto")
    }
    
    //Método a Probar                 |      Entrada      |       Salida Esperarada
    //sumar(a: Int, b: Int)           |a = 10, b=20       |30
    
    func testAddAssert(){
        print("XXXX testAddAssert()")
        //1.- Arrange
        let resultadoEsperado = 30
        var resultadoActual: Int
        //2.- Act
        resultadoActual = sut.add(n1: 10, n2: 20)
        //3.- Assert
        XCTAssertEqual(resultadoEsperado, resultadoActual)
    }
    
    func testAddBDD(){
        print("XXXX testAddBDD()")
        //1.- Given
        let resultadoEsperado = 30
        var resultadoActual: Int
        //2.- When
        resultadoActual = sut.add(n1: 10, n2: 20)
        //3.- Then
        XCTAssertEqual(resultadoEsperado, resultadoActual)
    }
    
    func testAdd(){
        print("XXXX testAdd()")
        XCTAssertEqual(30, sut.add(n1: 10, n2: 20))
    }
    
    func testAssertTypes(){
        print("XXXX testAssertTypes()")
        XCTAssertTrue(1 == 1)
        XCTAssertFalse(1 == 2)
        XCTAssertNil(nil)
        XCTAssertNotNil(sut)
        XCTAssertEqual(30, sut.add(n1: 10, n2: 20))
        XCTAssertEqual("alberto", "alberto")
        XCTAssertGreaterThan(10, 1, "Necesito que sea mayor")
    }
    
    func testSubtract(){
        print("XXXX testSubtract()")
        XCTAssertEqual(4, sut.subtract(n1: 11, n2: 7))
    }
    
    func testDivide(){
        print("XXXX testDivide()")
        XCTAssertEqual(2, sut.divide(n1: 4, n2: 2))
    }
    
    func testDivideByZero(){
        print("XXXX testDivideByZero()")
        XCTAssertEqual(2, try sut.divideByZero(n1: 4, n2: 2))
        XCTAssertThrowsError(try sut.divideByZero(n1: 4, n2: 0))
    }
    
    func testDisable(){
        print("XXXX testDivideByZero()")
        XCTAssertThrowsError(try sut.divideByZero(n1: 4, n2: 0))
    }
    
    func testPerformanceExample(){
        self.measure {
            sut.divide(n1: 4, n2: 2)
        }
    }
    
    func testArraySquared(){
        //Given
        var numbers = [Int]()
        for n in 1...4{
            numbers.append(n)
        }
        //When
        let numbersSquared = sut.arraySquared(numberArray: numbers)
        //Then
        var expectedResult = [Int]()
        expectedResult.append(1)
        expectedResult.append(4)
        expectedResult.append(9)
        expectedResult.append(16)
        XCTAssertEqual(expectedResult, numbersSquared)
    }
    
    func testArraySquared2(){
        var numbers = [Int]()
        for n in 1...4{
            numbers.append(n)
        }
        let numbersSquared = sut.arraySquared2(numberArray: numbers)
        var expectedResult = [Int]()
        expectedResult.append(1)
        expectedResult.append(4)
        expectedResult.append(9)
        expectedResult.append(16)
        XCTAssertEqual(expectedResult, numbersSquared)
    }
    
    func testArraySquaredMeasure(){
        var numbers = [Int]()
        for n in 1...5000000{
            numbers.append(n)
        }
        self.measure {
            sut.arraySquared(numberArray: numbers)
        }
    }
    
    func testArraySquaredMeasure2(){
        var numbers = [Int]()
        for n in 1...5000000{
            numbers.append(n)
        }
        self.measure {
            sut.arraySquared2(numberArray: numbers)
        }
    }

}
