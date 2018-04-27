//
//  MainViewController.swift
//  SmallestСircle
//
//  Created by Vladyslav Yakovlev on 25.04.2018.
//  Copyright © 2018 Vladyslav Yakovlev. All rights reserved.
//

import Cocoa

final class MainViewController: NSViewController {

    @IBOutlet weak var mainView: NSView!
    
    @IBOutlet weak var numberField: NSTextField!
    
    private var circleLayer: CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let сlickGesture = NSClickGestureRecognizer(target: self, action: #selector(mainViewClicked(сlick:)))
        mainView.addGestureRecognizer(сlickGesture)
    }
    
    private func drawPoint(with center: CGPoint) {
        Drawer.drawPoint(on: mainView, with: center, diameter: 6, color: .black)
    }
    
    private func drawCircle(_ circle: Circle) {
        circleLayer?.removeFromSuperlayer()
        let radius = CGFloat(circle.radius)
        let center = CGPoint(x: CGFloat(circle.center.x), y: CGFloat(circle.center.y))
        circleLayer = Drawer.drawCircle(on: mainView, with: center, radius: radius, color: .blue)
    }
    
    @objc private func mainViewClicked(сlick: NSGestureRecognizer) {
        let position = сlick.location(in: mainView)
        drawPoint(with: position)
        resignNumberField()
    }

    @IBAction func findButtonTapped(_ sender: NSButton) {
        guard let sublayers = mainView.layer?.sublayers else {
            return
        }
        
        let points = sublayers.map { point in
            Point(x: Float(point.position.x), y: Float(point.position.y))
        }
        if let circle = SmallestCircle.findCircle(for: points) {
            drawCircle(circle)
        }
        
        resignNumberField()
    }
    
    @IBAction func generateButtonTapped(_ sender: NSButton) {
        guard let number = Int(numberField.stringValue), number <= 10000 else {
            return
        }
        
        let minY: CGFloat = 100
        let maxY = mainView.frame.height - minY
        let value = (mainView.frame.height - minY)/2
        let minX = (mainView.frame.width - value - 100)/2
        let maxX = mainView.frame.width - minX
        
        for _ in 1...number {
            let randomX = Random.randomInRange(Int(minX), Int(maxX))
            let randomY = Random.randomInRange(Int(minY), Int(maxY))
            let randomPoint = CGPoint(x: randomX, y: randomY)
            drawPoint(with: randomPoint)
        }
        
        resignNumberField()
    }
    
    @IBAction func clearButtonTapped(_ sender: NSButton) {
        guard let sublayers = mainView.layer?.sublayers else {
            return
        }
        
        for layer in sublayers {
            layer.removeFromSuperlayer()
        }
        
        resignNumberField()
    }
    
    override func mouseDown(with event: NSEvent) {
        resignNumberField()
    }
    
    private func resignNumberField() {
        NSApp.mainWindow?.makeFirstResponder(nil)
    }
}

