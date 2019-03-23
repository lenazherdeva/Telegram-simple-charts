//
//  ChartViewController.swift
//  Telegram_charts
//
//  Created by Zherdeva Elena on 20/03/2019.
//  Copyright © 2019 Zherdeva Elena. All rights reserved.
//

import Foundation


import UIKit

class ChartViewController: UIViewController {
    
    
    @IBOutlet weak var chartView: Chart!
    
    var charts: [ChartData] = []
    var selectedGraph: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.charts = charts
        chartView.selectedGraph = selectedGraph
        
        
        for i in 0..<2 {
            let button = UIButton(frame: CGRect(x: (x+i*10), y: (100+10*i), width: 100, height: 50))
            button.backgroundColor = .green
            button.setTitle("Test Button", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            self.view.addSubview(button)
        }

    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
        
}


