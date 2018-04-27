//
//  Point.swift
//  SmallestСircle
//
//  Created by Vladyslav Yakovlev on 25.04.2018.
//  Copyright © 2018 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

struct Point {
    
    var x: Float
    
    var y: Float
    
    func subtract(_ point: Point) -> Point {
        return Point(x: x - point.x, y: y - point.y)
    }
    
    func distance(to point: Point) -> Float {
        return sqrtf(powf((x - point.x), 2) + powf((y - point.y), 2))
    }
    
    func cross(_ point: Point) -> Float {
        return x * point.y - y * point.x
    }
}
