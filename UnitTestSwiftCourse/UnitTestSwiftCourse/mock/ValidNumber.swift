//
//  ValidNumber.swift
//  UnitTestSwiftCourse
//
//  Created by Alberto Palomar Robledo on 16/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

import Foundation

class ValidNumber {
    func check(number: Int)->Bool{
        if(number>=0 && number<10){
            return true
        }else{
            return false
        }
    }
}
