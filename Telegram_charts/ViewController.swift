//
//  ViewController.swift
//  Telegram_charts
//
//  Created by Zherdeva Elena on 12/03/2019.
//  Copyright © 2019 Zherdeva Elena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ChartView: Chart!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChartView.inputData = getData()
        //print(ChartView.inputData)
        print("viewDidLoad")
    }
    
    private func getData()-> [DataEntry] {
        var result: [DataEntry] = []
        for i in 0..<30 {
            let value = Int(arc4random() % 100)
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            
            result.append(DataEntry(value: value, label: formatter.string(from: date)))
        }
        //print("RESULT", result)
        return result
    }
    
}

private func getDataFromFile()-> [DataEntry] {
    var result: [DataEntry] = []
    if let path = Bundle.main.path(forResource: "chart_data", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                // do stuff
            }
        } catch {
            // handle error
        }
    }
    
    
    return result
}

