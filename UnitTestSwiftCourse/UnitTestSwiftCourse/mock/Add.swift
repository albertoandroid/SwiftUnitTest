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
    
    init(validNumber: ValidNumber) {
        self.validNumber = validNumber
    }
    
    func add(a: Int, b: Int)-> Int{
        if(validNumber.check(number: a) && validNumber.check(number: b)){
            return a + b
        }
        return 0
    }
}
