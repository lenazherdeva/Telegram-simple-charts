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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.charts = charts
    }

}
