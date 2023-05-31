//
//  TriangleCalculatorViewModel.swift
//  Triangle Inequality
//
//  Created by John Nikko Borja on 9/10/22.
//

import RxCocoa

final class TriangleCalculatorViewModel: NSObject {
    let isTriangleInequality = BehaviorRelay<Bool>(value: false)
    var triangle: [Int] = []
    var triangleObject: Triangle?
    
    
    func combinationsWithoutRepetition(with combinations: [Int] = [], from array: [Int], size: Int, startingAt: Int = 0) {
        if size == 0 {
            triangleObject = Triangle.init(sides: combinations)
            guard let result = triangleObject?.triangleInequality() else { return }
            triangle.append(result ? 1 : 0)
            return
        }

        for i in startingAt ... array.count - size {
            var remaining = array
            remaining.remove(at: i)
            combinationsWithoutRepetition(with: combinations + [array[i]], from: remaining, size: size - 1, startingAt: i)
        }
    }
    
    func manipulateFormData(data: String) -> [Int]? {
        if data.contains(",") {
            let splitData = data.split(separator: ",")
            if splitData.count < 3 {
                isTriangleInequality.accept(false)
                return nil
            }
            
            let intData = splitData.compactMap { Int($0) }
            if (triangle.count > 0) { triangle.removeAll() }
            
            return intData
        }
        
        isTriangleInequality.accept(false)
        return nil
    }
    
    func checkResult() {
        if (triangle.contains(1)) {
            isTriangleInequality.accept(true)
        } else {
            isTriangleInequality.accept(false)
        }
    }
}
