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

    func drawChart() {
        drawLines()
    }
    
    func drawLines() {
        
        let baseLine: CAShapeLayer = drawLineFromPont(fromPoint: CGPoint(x: 0, y: self.bounds.maxY), toPoint: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY), color: mainColor, width: 1.0, alpha: 1.0)
        
        let verticalLine: CAShapeLayer = drawLineFromPont(fromPoint: CGPoint(x: self.bounds.maxX, y: 0), toPoint: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY), color: mainColor, width: 1.0, alpha: 1.0)
        
        let hypotenuse: CAShapeLayer = drawLineFromPont(fromPoint: CGPoint(x: 0, y: self.bounds.maxY), toPoint: CGPoint(x: self.bounds.maxX, y: 0), color: mainColor, width: 1.0, alpha: 1.0)
        
        self.layer.addSublayer(baseLine)
        self.layer.addSublayer(verticalLine)
        self.layer.addSublayer(hypotenuse)
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
}
