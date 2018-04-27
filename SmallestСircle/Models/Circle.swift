//
//  Circle.swift
//  SmallestСircle
//
//  Created by Vladyslav Yakovlev on 25.04.2018.
//  Copyright © 2018 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

struct Circle {
    
    var radius: Float
    
    var center: Point
    
    func contains(_ point: Point) -> Bool {
        return center.distance(to: point) <= radius
    }
    
    func contains(_ points: [Point]) -> Bool {
        for point in points {
            if !contains(point) {
                return false
            }
        }
        return true
    }
}
