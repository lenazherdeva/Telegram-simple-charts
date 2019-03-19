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
        print("viewDidLoad")
        do {
            //charts = try getDataFromFile()
            ChartView.charts = try getDataFromFile()
            //print(charts)
        } catch {
            fatalError("Can't parse json data")
        }
        //let returnedData = getDataFromChart(index: 3)
        //ChartView.inputData = returnedData.data
        //ChartView.colors = returnedData.color
    }
    
    private func getDataFromChart(index: Int )-> (data: [DataEntry], color: Strings) {
        let chart = charts[index]
        let columns = chart.columns
        var result: [DataEntry] = []
        let x = columns["x"]!
        let y0 = columns["y0"]!
        let size = x.count
        for i in 0..<size {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(x[i]))
            result.append(DataEntry(value: y0[i], label: formatter.string(from: date)))
        }
        return (result, chart.colors)
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
        return result
    }
    
    func getDates() {
        let chart = charts[0]
        let columns = chart.columns
        let y1 = columns["y1"]
        let y0 = columns["y0"]
        let x = columns["x"]
    
        var dates = [String]()
        for i in 0..<x!.count {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(x![i]))
            dates.append(formatter.string(from: date))
        }
        
        print(dates)
    }
    
    func getDataFromFile() throws -> [ChartData] {
        guard let url = Bundle.main.url(forResource: "chart_data", withExtension: "json") else {
            fatalError("Can't find json file")
        }
        let jsonData = try Data(contentsOf: url)
        let chart = try JSONDecoder().decode([ChartData].self, from: jsonData)
        return chart
    }
}
