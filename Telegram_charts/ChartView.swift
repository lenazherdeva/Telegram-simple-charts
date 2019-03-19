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
    private let mainLayer: CALayer = CALayer()
    
    // layer with main graph==line
    private let dataLayer: CALayer = CALayer()
    
    private let scrollView: UIScrollView = UIScrollView()
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    // colors of y0, y1, y2..
    //var colors = [String: String]()

    var charts: [ChartData] = []
    
    // points on a dataLayer
    //private var dataPoints: [CGPoint]?
    
    // input data points
    var inputData: [DataEntry]?
    private var dataPoints: [CGPoint]?
    
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
    
        self.drawLines(chart: charts[3])
    }
    

    
    /*private func convertDataToPoints(data: [DataEntry])-> [CGPoint] {
        print("convertData")
        if let max = data.max()?.value, let min = data.min()?.value {
            var result: [CGPoint] = []
            let minMaxRange: CGFloat = CGFloat(max - min) * topHorizontalLine
            
            for i in 0..<data.count {
                let height = dataLayer.frame.height * (1 - ((CGFloat(data[i].value) - CGFloat(min)) / minMaxRange))
                let point = CGPoint(x: CGFloat(i)*lineGap + 40, y: height)
                result.append(point)
            }
            return result
        }
        return []
    }*/
    
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
            dataLayer.addSublayer(shapeLayer)
            
        }
    }
    
    
    /*private func drawChart() {

        let aPath = UIBezierPath()
        aPath.move(to: dataPoints![0])
        
        for i in 1..<dataPoints!.count {
            aPath.addLine(to: dataPoints![i])
        }
        shapeLayer.path = aPath.cgPath
        //shapeLayer.strokeColor =
        //shapeLayer.strokeColor = UIColor(hexString: colors["y0"]!).cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
    }*/
}



