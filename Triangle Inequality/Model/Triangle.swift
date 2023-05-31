//
//  Triangle.swift
//  Triangle Inequality
//
//  Created by John Nikko Borja on 9/10/22.
//

import Foundation

class Triangle: NSObject {
    
    let firstSide: Int
    let secondSide: Int
    let thirdSide: Int
    
    init(firstSide: Int, secondSide: Int, thirdSide: Int) {
        self.firstSide = firstSide
        self.secondSide = secondSide
        self.thirdSide = thirdSide
    }
    
    init(sides: [Int]) {
        self.firstSide = sides[0]
        self.secondSide = sides[1]
        self.thirdSide = sides[2]
    }
    
    func triangleInequality() -> Bool {
        return (firstSide + secondSide) > thirdSide
            && (firstSide + thirdSide) > secondSide
            && (secondSide + thirdSide) > firstSide
    }
}
