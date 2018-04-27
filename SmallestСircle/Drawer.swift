//
//  Drawer.swift
//  SmallestСircle
//
//  Created by Vladyslav Yakovlev on 26.04.2018.
//  Copyright © 2018 Vladyslav Yakovlev. All rights reserved.
//

import Cocoa

final class Drawer {
    
    class func drawPoint(on view: NSView, with center: CGPoint, diameter: CGFloat, color: NSColor) {
        let point = CAShapeLayer()
        let size = CGSize(width: diameter, height: diameter)
        let bounds = CGRect(origin: .zero, size: size)
        point.path = CGPath(ellipseIn: bounds, transform: nil)
        point.bounds = bounds
        point.position = center
        point.fillColor = color.cgColor
        view.layer?.addSublayer(point)
    }
    
    class func drawCircle(on view: NSView, with center: CGPoint, radius: CGFloat, color: NSColor) -> CAShapeLayer {
        let circle = CAShapeLayer()
        let size = CGSize(width: 2*radius, height: 2*radius)
        let bounds = CGRect(origin: .zero, size: size)
        circle.path = CGPath(ellipseIn: bounds, transform: nil)
        circle.bounds = bounds
        circle.position = center
        circle.fillColor = NSColor.clear.cgColor
        circle.strokeColor = color.cgColor
        circle.lineWidth = 3
        view.layer?.addSublayer(circle)
        return circle
    }
}
