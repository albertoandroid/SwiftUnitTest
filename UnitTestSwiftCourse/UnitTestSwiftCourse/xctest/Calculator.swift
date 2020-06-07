//
//  Calculator.swift
//  UnitTestSwiftCourse
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
func restar(                |Este método devuelve un int
    numero1: Int,           |
    numero2: Int            |
    ): Int                  |-> Nos devuelve un Entero con el resultado
---------------------------------------------------------------------
 */

import Foundation

class Calculator {
    func add(n1: Int, n2: Int)->Int{
        return n1 + n2
    }
    
    func subtract(n1: Int, n2: Int)->Int{
        return n1 - n2
    }
    
    func divide(n1: Int, n2: Int)->Int{
        return n1 / n2
    }
    
    func divideByZero(n1: Int, n2: Int) throws -> Int{
        if(n2 == 0){
            throw SomeError.ZeroError
        }
        return n1 / n2
    }
}

enum SomeError: Error{
    case ZeroError
}
