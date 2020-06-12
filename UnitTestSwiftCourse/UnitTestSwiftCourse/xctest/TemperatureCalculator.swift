//
//  TemperatureCalculator.swift
//  UnitTestSwiftCourse
//
//  Created by Alberto Palomar Robledo on 12/06/2020.
//  Copyright © 2020 Alberto Palomar Robledo. All rights reserved.
//

import Foundation

class TemperatureCalculator{
    func toFahrenheit(degree: Double)-> Double{
        return degree * 9 / 5 + 32
    }
    
    func toDegrees(fahrenheit: Double)-> Double{
        return (fahrenheit - 32) * 5 / 9
    }
}
