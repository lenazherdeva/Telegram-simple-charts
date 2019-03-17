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
    
    // horizontal lines layer
    //private let gridLayer: CALayer = CALayer()
    
    let lineGap: CGFloat = 60.0
    let topSpace: CGFloat = 40.0
    let bottomSpace: CGFloat = 40.0
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    
    // points on a dataLayer
    //private var dataPoints: [CGPoint]?
    
    // input data points
    var inputData: [DataEntry]?
    private var dataPoints: [CGPoint]?
    
    

    private var shapeLayer = CAShapeLayer()
    
    
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
        //print(inputData)
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        scrollView.contentSize = CGSize(width: CGFloat(inputData!.count) * lineGap, height: self.frame.size.height)
        mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(inputData!.count) * lineGap, height: self.frame.size.height)
        dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
        
        dataPoints = convertDataToPoints(data: inputData!)
        print("layoutSubviews")
        
        //print(dataPoints)
        
        self.drawChart()
    }
    

    
    private func convertDataToPoints(data: [DataEntry])-> [CGPoint] {
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
    }
    
    
    private func drawChart() {

        let aPath = UIBezierPath()
        aPath.move(to: dataPoints![0])
        
        for i in 1..<dataPoints!.count {
            aPath.addLine(to: dataPoints![i])
        }
        shapeLayer.path = aPath.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
    }
}



