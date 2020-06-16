//
//  Add.swift
//  UnitTestSwiftCourse
//
//  Created by Alberto Palomar Robledo on 16/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

import Foundation

class Add {
    
    var validNumber: ValidNumber
    var print: Print?
    
    init(validNumber: ValidNumber) {
        self.validNumber = validNumber
    }
    init(validNumber: ValidNumber, print: Print) {
        self.validNumber = validNumber
        self.print = print
    }
    
    func add(a: Int, b: Int)-> Int{
        if(validNumber.check(number: a) && validNumber.check(number: b)){
            return a + b
        }
        return 0
    }
    
    func addPrint(a: Int, b: Int){
        if(validNumber.check(number: a) && validNumber.check(number: b)){
            print?.showMessage(numero: a+b)
        }else{
            print?.showError()
        }
    }
}
