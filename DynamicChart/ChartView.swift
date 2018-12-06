//
//  ChartView.swift
//  DynamicChart
//
//  Created by ChenAlan on 2018/12/6.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import UIKit

class ChartView: UIView {
    
    let mainColor = UIColor.blue
    let xRatio: CGFloat = 0.3
    let yRatio: CGFloat = 0.7
    
    func drawChart() {
        drawLines()
        drawSteps()
    }
    
    func drawLines() {
        
        let baseLineStartPoint = CGPoint(x: 0, y: self.bounds.maxY)
        let baseLineEndPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
        let xPos = self.bounds.maxX * xRatio
        let yPos = self.bounds.maxY * (1 - yRatio)
        let vertex = CGPoint(x: xPos, y: yPos)
        
        let baseLine: CAShapeLayer = drawLineFromPont(fromPoint: baseLineStartPoint, toPoint: baseLineEndPoint, color: mainColor, width: 1.0, alpha: 1.0)
        
        let lineFromStart: CAShapeLayer = drawLineFromPont(fromPoint: baseLineStartPoint, toPoint: vertex, color: mainColor, width: 1.0, alpha: 1.0)
        
        let lineToEnd: CAShapeLayer = drawLineFromPont(fromPoint: vertex, toPoint: baseLineEndPoint, color: mainColor, width: 1.0, alpha: 1.0)
        
        self.layer.addSublayer(baseLine)
        self.layer.addSublayer(lineFromStart)
        self.layer.addSublayer(lineToEnd)
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
        
        let baseLineStartPoint = CGPoint(x: 0, y: self.bounds.maxY)
        let baseLineEndPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
        let xPos = self.bounds.maxX * xRatio
        let yPos = self.bounds.maxY * (1 - yRatio)
        let vertex = CGPoint(x: xPos, y: yPos)
        
        let graphPath = UIBezierPath()
        graphPath.move(to: baseLineStartPoint)
        graphPath.addLine(to: vertex)
        graphPath.addLine(to: baseLineEndPoint)
        graphPath.close()
        
        // Shape fill color
        let graphLayer = CAShapeLayer()
        graphLayer.path = graphPath.cgPath
        graphLayer.fillColor = mainColor.cgColor
        graphLayer.shouldRasterize = true
        graphLayer.rasterizationScale = UIScreen.main.scale
        graphLayer.opacity = 0.3
        
        self.layer.addSublayer(graphLayer)
    }
}
