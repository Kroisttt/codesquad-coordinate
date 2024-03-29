//
//  Converter.swift
//  CoordinateCalculator
//
//  Created by 이진영 on 25/04/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

struct Converter {
    static func shape(coordinates: [String]) throws -> Drawable {
        var points: [MyPoint] = []
        
        for coordinate in coordinates {
            points.append(try convertPoint(coordinate: coordinate))
        }
        
        switch points.count {
        case 1:
            return points[0]
        case 2:
            return MyLine(pointA: points[0], pointB: points[1])
        case 3:
            return MyTriangle(pointA: points[0], pointB: points[1], pointC: points[2])
        case 4:
            let verificationResult = try RectVerifier.verifyRect(points: points)
            return MyRect(origin: verificationResult.origin, size: verificationResult.size)
        default:
            throw InputError.invalidInput
        }
    }
    
    private static func convertPoint(coordinate: String) throws -> MyPoint {
        let numbersText = coordinate.components(separatedBy: ["(", ")"]).joined().split(separator: ",")
        var numbers: [Int] = []
        
        for numberText in numbersText {
            numbers.append(try convertStringToInt(numberText: String(numberText)))
        }
        
        return MyPoint(x: numbers[0], y: numbers[1])
    }
    
    private static func convertStringToInt(numberText: String) throws -> Int {
        guard let number = Int(numberText) else {
            throw InputError.invalidInput
        }
        
        guard 0...24 ~= number else {
            throw InputError.invalidRange
        }
        
        return number
    }
}
