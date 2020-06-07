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
    
    func testCalculatorNotNil(){
        print("XXXX testCalculatorNotNil()")
        XCTAssertNotNil(sut, "SUT debería ser not nil en este punto")
    }

}
