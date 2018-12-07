//
//  ChartView.swift
//  DynamicChart
//
//  Created by ChenAlan on 2018/12/6.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import UIKit

class ChartView: UIView {
    
    let blueColor = UIColor.blue
    let yellowColor = UIColor.yellow
    let greenColor = UIColor.green
    var blueXRatio: CGFloat = 0.3
    var blueYRatio: CGFloat = 0.7
    var yellowXRatio: CGFloat = 0.7
    var yellowYRatio: CGFloat = -0.7
    var controlBlue: Bool = true
    var controlYellow: Bool = false
    
    func initGestureRecognizers() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(didPan(panGR:)))
        self.addGestureRecognizer(panGR)
    }
    
    @objc func didPan(panGR: UIPanGestureRecognizer) {
        
        let translation = panGR.translation(in: self)
        
        if controlBlue {
            blueXRatio += translation.x / 100
            blueYRatio -= translation.y / 100
        } else if controlYellow {
            yellowXRatio += translation.x / 100
            yellowYRatio -= translation.y / 100
        }
        
        panGR.setTranslation(CGPoint.zero, in: self)
        
        drawChart()
    }
    
    func drawChart() {
        clearAll()
        drawLines()
        drawSteps()
    }
    
    func clearAll() {
        self.layer.sublayers?.removeAll()
    }
    
    func drawLines() {
        
        let baseLineStartPoint = CGPoint(x: 0, y: self.bounds.maxY / 2)
        let baseLineEndPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 2)
        
        // blue triangle
        let blueXPos = self.bounds.maxX * blueXRatio
        let blueYPos = self.bounds.maxY / 2 * (1 - blueYRatio)
        let blueVertex = CGPoint(x: blueXPos, y: blueYPos)
        
        let blueBaseLine: CAShapeLayer = drawLineFromPont(fromPoint: baseLineStartPoint, toPoint: baseLineEndPoint, color: blueColor, width: 1.0, alpha: 1.0)
        
        let blueLineFromStart: CAShapeLayer = drawLineFromPont(fromPoint: baseLineStartPoint, toPoint: blueVertex, color: blueColor, width: 1.0, alpha: 1.0)
        
        let blueLineToEnd: CAShapeLayer = drawLineFromPont(fromPoint: blueVertex, toPoint: baseLineEndPoint, color: blueColor, width: 1.0, alpha: 1.0)
        
        // yellow triangle
        
        let yellowXPos = self.bounds.maxX * yellowXRatio
        let yellowYPos = self.bounds.maxY / 2 * (1 - yellowYRatio)
        let yellowVertex = CGPoint(x: yellowXPos, y: yellowYPos)
        
        let yellowBaseLine: CAShapeLayer = drawLineFromPont(fromPoint: baseLineStartPoint, toPoint: baseLineEndPoint, color: yellowColor, width: 1.0, alpha: 1.0)
        
        let yellowLineFromStart: CAShapeLayer = drawLineFromPont(fromPoint: baseLineStartPoint, toPoint: yellowVertex, color: yellowColor, width: 1.0, alpha: 1.0)
        
        let yellowLineToEnd: CAShapeLayer = drawLineFromPont(fromPoint: yellowVertex, toPoint: baseLineEndPoint, color: yellowColor, width: 1.0, alpha: 1.0)
        
        // add two tiangles
        self.layer.addSublayer(blueBaseLine)
        self.layer.addSublayer(blueLineFromStart)
        self.layer.addSublayer(blueLineToEnd)
        self.layer.addSublayer(yellowBaseLine)
        self.layer.addSublayer(yellowLineFromStart)
        self.layer.addSublayer(yellowLineToEnd)
    }
    
    func drawLineFromPont(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor, width: CGFloat, alpha: Float) -> CAShapeLayer {
        
        let path = UIBezierPath()
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        
        let lineShapeLayer = CAShapeLayer()
        lineShapeLayer.path = path.cgPath
        lineShapeLayer.strokeColor = color.cgColor
        lineShapeLayer.lineWidth = width
        
        lineShapeLayer.fillColor = UIColor.clear.cgColor
        lineShapeLayer.shouldRasterize = true
        lineShapeLayer.rasterizationScale = UIScreen.main.scale
        lineShapeLayer.opacity = alpha
        
        return lineShapeLayer
    }
    
    func drawSteps() {
        
        let baseLineStartPoint = CGPoint(x: 0, y: self.bounds.maxY / 2)
        let baseLineEndPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 2)
        
        // blue triangle
        let blueXPos = self.bounds.maxX * blueXRatio
        let blueYPos = self.bounds.maxY / 2 * (1 - blueYRatio)
        let blueVertex = CGPoint(x: blueXPos, y: blueYPos)
        
        let blueGraphPath = UIBezierPath()
        blueGraphPath.move(to: baseLineStartPoint)
        blueGraphPath.addLine(to: blueVertex)
        blueGraphPath.addLine(to: baseLineEndPoint)
        blueGraphPath.close()
        
        // Shape fill color
        let blueGraphLayer = CAShapeLayer()
        blueGraphLayer.path = blueGraphPath.cgPath
        blueGraphLayer.fillColor = blueColor.cgColor
        blueGraphLayer.shouldRasterize = true
        blueGraphLayer.rasterizationScale = UIScreen.main.scale
        blueGraphLayer.opacity = 0.3
        
        // yellow triangle
        let yellowXPos = self.bounds.maxX * yellowXRatio
        let yellowYPos = self.bounds.maxY / 2 * (1 - yellowYRatio)
        let yellowVertex = CGPoint(x: yellowXPos, y: yellowYPos)
        
        let yellowGraphPath = UIBezierPath()
        yellowGraphPath.move(to: baseLineStartPoint)
        yellowGraphPath.addLine(to: yellowVertex)
        yellowGraphPath.addLine(to: baseLineEndPoint)
        yellowGraphPath.close()
        
        // Shape fill color
        let yellowGraphLayer = CAShapeLayer()
        yellowGraphLayer.path = yellowGraphPath.cgPath
        yellowGraphLayer.fillColor = yellowColor.cgColor
        yellowGraphLayer.shouldRasterize = true
        yellowGraphLayer.rasterizationScale = UIScreen.main.scale
        yellowGraphLayer.opacity = 0.3
        
        // green triangle
        let greenXPos1 = self.bounds.maxX * blueXRatio
        let greenYPos1 = blueXPos > yellowXPos ? blueYPos + (yellowYPos - self.bounds.maxY / 2) * (self.bounds.maxX - greenXPos1) / (self.bounds.maxX - yellowXPos) : blueYPos + (yellowYPos - self.bounds.maxY / 2) * greenXPos1 / yellowXPos
        let greenVertex1 = CGPoint(x: greenXPos1, y: greenYPos1)
        let greenXPos2 = self.bounds.maxX * yellowXRatio
        let greenYPos2 = yellowXPos > blueXPos ? yellowYPos + (blueYPos - self.bounds.maxY / 2) * (self.bounds.maxX - greenXPos2) / (self.bounds.maxX - blueXPos) : yellowYPos + (blueYPos - self.bounds.maxY / 2) * greenXPos2 / blueXPos
        let greenVertex2 = CGPoint(x: greenXPos2, y: greenYPos2)
        
        let greenGraphPath = UIBezierPath()
        greenGraphPath.move(to: baseLineStartPoint)
        if greenXPos1 < greenXPos2 {
            greenGraphPath.addLine(to: greenVertex1)
            greenGraphPath.addLine(to: greenVertex2)
        } else if greenXPos1 > greenXPos2 {
            greenGraphPath.addLine(to: greenVertex2)
            greenGraphPath.addLine(to: greenVertex1)
        } else {
            greenGraphPath.addLine(to: greenVertex1)
        }
        greenGraphPath.addLine(to: baseLineEndPoint)
        greenGraphPath.close()
        
        // Shape fill color
        let greenGraphLayer = CAShapeLayer()
        greenGraphLayer.path = greenGraphPath.cgPath
        greenGraphLayer.fillColor = greenColor.cgColor
        greenGraphLayer.shouldRasterize = true
        greenGraphLayer.rasterizationScale = UIScreen.main.scale
        greenGraphLayer.opacity = 0.3
        
        // two triangles
        self.layer.addSublayer(blueGraphLayer)
        self.layer.addSublayer(yellowGraphLayer)
        
        // third triangle
        self.layer.addSublayer(greenGraphLayer)
    }
}
