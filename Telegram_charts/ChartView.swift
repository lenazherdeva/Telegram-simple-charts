//
//  ChartView.swift
//  Telegram_charts
//
//  Created by Zherdeva Elena on 12/03/2019.
//  Copyright © 2019 Zherdeva Elena. All rights reserved.
//

import Foundation
import UIKit
 
 
 struct DataEntry {
    let value: Int
    let label: String
}
 
 extension DataEntry: Comparable {
     static func <(lhs: DataEntry, rhs: DataEntry) -> Bool {
        return lhs.value < rhs.value
    }
     static func ==(lhs: DataEntry, rhs: DataEntry) -> Bool {
        return lhs.value == rhs.value
     }
}
 
 
 class Chart: UIView {
 
    // contain dataLayer and pointsLayer
    let mainLayer: CALayer = CALayer()
    
    // layer with main graph==line
    let dataLayer: CALayer = CALayer()
    
    let scrollView: UIScrollView = UIScrollView()
        
    var charts: [ChartData] = []
    var selectedGraph: Int = 0
    
    let topSpace: CGFloat = 15.0
    let rightSpace: CGFloat = 10.0
    let bottomSpace: CGFloat = 15.0
    let leftSpace: CGFloat = 10.0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("required_init")
        setupView()
    }
    
     private func setupView() {
        mainLayer.addSublayer(dataLayer)
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
        print("setupView")
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        scrollView.contentSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        mainLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
        
        print("layoutSubviews")
        self.drawLines(chart: charts[selectedGraph])
    }
    
    private func drawLines(chart: ChartData, lowerValue: CGFloat = 0.0, upperValue: CGFloat = 1.0) {
        let types = chart.types
        let columns = chart.columns
        let x = chart.columns["x"]!
        let colors = chart.colors
        
        var dataTypes = [String]()
        var labels = [String]()
        for (key, value) in types {
            print(key, value)
            if value == "x" {
                labels = getDatesFromInt(x: columns[key]!)
            } else {
                dataTypes.append(key)
            }
        }
        
        let lowerNum = Int(CGFloat(x.count) * lowerValue)
        let upperNum = Int(CGFloat(x.count) * upperValue)
        
        let height = dataLayer.frame.height - topSpace - bottomSpace
        let width = dataLayer.frame.width - leftSpace - rightSpace
        
        var minY = CGFloat(0)
        var maxY = CGFloat(0)
        for type in dataTypes {
            let cur_minY = CGFloat(columns[type]!.min()!)
            if cur_minY < minY {
                minY = cur_minY
            }
            let cur_maxY = CGFloat(columns[type]!.max()!)
            if cur_maxY > maxY {
                maxY = cur_maxY
            }
        }
    
        let stepX = width / CGFloat(x.count - 1)
        let rangeY = maxY - minY
    
        
        for type in dataTypes {
            let shapeLayer = CAShapeLayer()
            let aPath = UIBezierPath()
            let column = Array(columns[type]![lowerNum..<upperNum])
            
        
            aPath.move(to:
                CGPoint(x: leftSpace, y: topSpace + height * (maxY - CGFloat(column[0])) / rangeY)
            )
            
            for i in 1..<columns[type]!.count {
                let point = CGPoint(x:leftSpace +  CGFloat(i) * stepX,
                                    y: topSpace + height * (maxY - CGFloat(column[i])) / rangeY)
                aPath.addLine(to: point)
            }
            
            shapeLayer.path = aPath.cgPath
            shapeLayer.strokeColor = UIColor(hexString: colors[type]!).cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = 2.0
            dataLayer.addSublayer(shapeLayer)
            
            
            
        }
    }
}



