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
    var charts: [ChartData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ChartView.inputData = getData()
        //print(ChartView.inputData)
        //print("viewDidLoad")
        do {
            charts = try getDataFromFile()
            print(charts)
        } catch {
            fatalError("Can't parse json data")
        }
    
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
    
    func getDataFromFile() throws -> [ChartData] {
        guard let url = Bundle.main.url(forResource: "chart_data", withExtension: "json") else {
            fatalError("Can't find json file")
        }
        
        let jsonData = try Data(contentsOf: url)
        print("JSON", jsonData)
        let chart = try JSONDecoder().decode([ChartData].self, from: jsonData)
        return chart
}
}

