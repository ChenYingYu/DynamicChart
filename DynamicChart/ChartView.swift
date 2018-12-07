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
    var greenVertex1 = CGPoint(x: 0.0, y: 0.0)
    var greenVertex2 = CGPoint(x: 0.0, y: 0.0)
    var baseLineStartPoint = CGPoint(x: 0, y: 0)
    var baseLineEndPoint = CGPoint(x: 0, y: 0)
    var firstNode = CGPoint(x: 0, y: 0)
    var secondNode = CGPoint(x: 0, y: 0)
    var thirdNode = CGPoint(x: 0, y: 0)
    var fourthNode = CGPoint(x: 0, y: 0)
    var fifthNode = CGPoint(x: 0, y: 0)
    var sixthNode = CGPoint(x: 0, y: 0)
    var seventhNode = CGPoint(x: 0, y: 0)
    var eighthNode = CGPoint(x: 0, y: 0)
    var ninthNode = CGPoint(x: 0, y: 0)
    var tenthNode = CGPoint(x: 0, y: 0)
    
    func setUp() {
        baseLineStartPoint = CGPoint(x: 0, y: self.bounds.maxY / 2)
        baseLineEndPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 2)
        firstNode.x = 0.0
        secondNode.x = self.bounds.maxX * (1/9)
        thirdNode.x = self.bounds.maxX * (2/9)
        fourthNode.x = self.bounds.maxX * (3/9)
        fifthNode.x = self.bounds.maxX * (4/9)
        sixthNode.x = self.bounds.maxX * (5/9)
        seventhNode.x = self.bounds.maxX * (6/9)
        eighthNode.x = self.bounds.maxX * (7/9)
        ninthNode.x = self.bounds.maxX * (8/9)
        tenthNode.x = self.bounds.maxX * (9/9)
    }
    
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
        
        baseLineStartPoint = CGPoint(x: 0, y: self.bounds.maxY / 2)
        baseLineEndPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 2)
        
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
        
        baseLineStartPoint = CGPoint(x: 0, y: self.bounds.maxY / 2)
        baseLineEndPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 2)
        
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
        greenVertex1 = CGPoint(x: greenXPos1, y: greenYPos1)
        let greenXPos2 = self.bounds.maxX * yellowXRatio
        let greenYPos2 = yellowXPos > blueXPos ? yellowYPos + (blueYPos - self.bounds.maxY / 2) * (self.bounds.maxX - greenXPos2) / (self.bounds.maxX - blueXPos) : yellowYPos + (blueYPos - self.bounds.maxY / 2) * greenXPos2 / blueXPos
        greenVertex2 = CGPoint(x: greenXPos2, y: greenYPos2)
        
        let greenGraphPath = UIBezierPath()
        greenGraphPath.move(to: baseLineStartPoint)
        if greenXPos1 < greenXPos2 {
            greenGraphPath.addLine(to: greenVertex1)
            greenGraphPath.addLine(to: greenVertex2)
            updateNodes(withVertex1: greenVertex1, vertex2: greenVertex2)
        } else if greenXPos1 > greenXPos2 {
            greenGraphPath.addLine(to: greenVertex2)
            greenGraphPath.addLine(to: greenVertex1)
            updateNodes(withVertex1: greenVertex2, vertex2: greenVertex1)
        } else {
            greenGraphPath.addLine(to: greenVertex1)
            updateNodes(withVertex1: greenVertex1, vertex2: greenVertex2)
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
    
    func updateNodes(withVertex1 vertex1: CGPoint, vertex2: CGPoint) {
        firstNode = getNode(withXPos: firstNode.x, byVertex1: vertex1, vertex2: vertex2)
        secondNode = getNode(withXPos: secondNode.x, byVertex1: vertex1, vertex2: vertex2)
        thirdNode = getNode(withXPos: thirdNode.x, byVertex1: vertex1, vertex2: vertex2)
        fourthNode = getNode(withXPos: fourthNode.x, byVertex1: vertex1, vertex2: vertex2)
        fifthNode = getNode(withXPos: fifthNode.x, byVertex1: vertex1, vertex2: vertex2)
        sixthNode = getNode(withXPos: sixthNode.x, byVertex1: vertex1, vertex2: vertex2)
        seventhNode = getNode(withXPos: seventhNode.x, byVertex1: vertex1, vertex2: vertex2)
        eighthNode = getNode(withXPos: eighthNode.x, byVertex1: vertex1, vertex2: vertex2)
        ninthNode = getNode(withXPos: ninthNode.x, byVertex1: vertex1, vertex2: vertex2)
        tenthNode = getNode(withXPos: tenthNode.x, byVertex1: vertex1, vertex2: vertex2)
        print("Nodes:\n\(firstNode.y - 200)\n\(secondNode.y - 200)\n\(thirdNode.y - 200)\n\(fourthNode.y - 200)\n\(fifthNode.y - 200)\n\(sixthNode.y - 200)\n\(seventhNode.y - 200)\n\(eighthNode.y - 200)\n\(ninthNode.y - 200)\n\(tenthNode.y - 200)")
    }
    
    func getNode(withXPos xPos: CGFloat, byVertex1 vertex1: CGPoint, vertex2: CGPoint) -> CGPoint {
        
        let yPos = getYPos(byXPos: xPos, vertex1: vertex1, andVertex2: vertex2)
        let node = CGPoint(x: xPos, y: yPos)
        
        return node
    }
    
    func getYPos(byXPos xPos: CGFloat, vertex1: CGPoint, andVertex2 vertex2: CGPoint) -> CGFloat {
        
        var yPos: CGFloat = 0.0
        let start = baseLineStartPoint
        let end = baseLineEndPoint
        if vertex1 == vertex2 {
            if xPos < vertex1.x {
                yPos += start.y + (vertex1.y - start.y) * (xPos - start.x) / (vertex1.x - start.x)
            } else {
                yPos += vertex1.y + (end.y - vertex1.y) * (xPos - vertex1.x) / (end.x - vertex1.x)
            }
        } else {
            if xPos < vertex1.x {
                yPos += start.y + (vertex1.y - start.y) * (xPos - start.x) / (vertex1.x - start.x)
            } else if xPos < vertex2.x {
                yPos += vertex1.y + (vertex2.y - vertex1.y) * (xPos - vertex1.x) / (vertex2.x - vertex1.x)
            } else {
                yPos += vertex2.y + (end.y - vertex2.y) * (xPos - vertex2.x) / (end.x - vertex2.x)
            }
        }
        return yPos
    }
}
