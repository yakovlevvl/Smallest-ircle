//
//  SmallestCircle.swift
//  SmallestСircle
//
//  Created by Vladyslav Yakovlev on 25.04.2018.
//  Copyright © 2018 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

class SmallestCircle {
    
    class func findCircle(for points: [Point]) -> Circle? {
        let shuffledPoints = points.shuffled()
        
        var circle: Circle?
        
        for (index, point) in shuffledPoints.enumerated() {
            if circle == nil || !circle!.contains(point) {
                circle = findCircle(for: Array(shuffledPoints[0...index]), boundaryPoint: point)
            }
        }
        
        return circle
    }
    
    class private func findCircle(for points: [Point], boundaryPoint: Point) -> Circle {
        var circle = Circle(radius: 0, center: boundaryPoint)
        
        for (index, point) in points.enumerated() {
            if !circle.contains(point) {
                if circle.radius == 0 {
                    circle = makeCircleWithDiameter(point, boundaryPoint)
                } else {
                    circle = findCircle(for: Array(points[0...index]), boundaryPoints: boundaryPoint, point)
                }
            }
        }
        
        return circle
    }
    
    class private func findCircle(for points: [Point], boundaryPoints a: Point, _ b: Point) -> Circle {
        let circle = makeCircleWithDiameter(a, b)
        var leftCircle: Circle?
        var rightCircle: Circle?
        
        let ab = a.subtract(b)
        
        for point in points {
            if circle.contains(point) {
                continue
            }
            
            let cross = ab.cross(point.subtract(b))
            let c = makeCircumcircle(a, b, point)
            
            if c == nil {
                continue
            } else if cross > 0, leftCircle == nil || ab.cross(c!.center.subtract(b)) > ab.cross(leftCircle!.center.subtract(b)) {
                leftCircle = c
            } else if cross < 0, rightCircle == nil || ab.cross(c!.center.subtract(b)) < ab.cross(rightCircle!.center.subtract(b)) {
                rightCircle = c
            }
        }
        
        if leftCircle == nil, rightCircle == nil {
            return circle
        } else if leftCircle == nil {
            return rightCircle!
        } else if rightCircle == nil {
            return leftCircle!
        } else {
            return leftCircle!.radius <= rightCircle!.radius ? leftCircle! : rightCircle!
        }
    }
    
    class private func makeCircleWithDiameter(_ a: Point, _ b: Point) -> Circle {
        let center = Point(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
        let radius = max(center.distance(to: a), center.distance(to: b))
        return Circle(radius: radius, center: center)
    }
    
    class private func makeCircumcircle(_ a: Point, _ b: Point, _ c: Point) -> Circle? {
        let ox = (min(min(a.x, b.x), c.x) + max(min(a.x, b.x), c.x)) / 2
        let oy = (min(min(a.y, b.y), c.y) + max(min(a.y, b.y), c.y)) / 2
        let ax = a.x - ox, ay = a.y - oy
        let bx = b.x - ox, by = b.y - oy
        let cx = c.x - ox, cy = c.y - oy
        let d = (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by)) * 2
        
        if d == 0 {
            return nil
        }
        let x = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) +
            (cx * cx + cy * cy) * (ay - by)) / d
        let y = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) +
            (cx * cx + cy * cy) * (bx - ax)) / d
        let center = Point(x: ox + x, y: oy + y)
        let radius = max(max(center.distance(to: a), center.distance(to: b)), center.distance(to: c))
        return Circle(radius: radius, center: center)
    }
}
