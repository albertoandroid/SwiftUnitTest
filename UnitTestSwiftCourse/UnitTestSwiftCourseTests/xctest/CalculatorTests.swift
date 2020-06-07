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

}
