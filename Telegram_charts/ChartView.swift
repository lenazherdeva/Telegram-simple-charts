//
//  ChartView.swift
//  Telegram_charts
//
//  Created by Zherdeva Elena on 12/03/2019.
//  Copyright © 2019 Zherdeva Elena. All rights reserved.
//

import Foundation
import UIKit


class Chart: UIView {
    
    // layer with main line
    private let dataLayer: CALayer = CALayer()
    
    // horizontal lines layer
    private let gridLayer: CALayer = CALayer()
    
    // points on a dataLayer
    private var dataPoints: [CGPoint]?
    
    private let points: [CGPoint] = [
        CGPoint(x: 0, y: 1),
        CGPoint(x: 12, y: 3),
        CGPoint(x: 5, y: 4),
        CGPoint(x: 8, y: 11),
        CGPoint(x: 7, y: 2)
        ].sorted { $0.x < $1.x }
    
    private var shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.drawChart()
    
    }
    
    private func drawChart() {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: 0, y: 0))
        
        let randomInt = CGFloat.random(in: 5..<20)
        
        for point in points {
            aPath.addLine(to: CGPoint(x: point.x * 20, y: point.y * randomInt))
        }
        shapeLayer.path = aPath.cgPath

        
    }
    
    
    
    
    
}
