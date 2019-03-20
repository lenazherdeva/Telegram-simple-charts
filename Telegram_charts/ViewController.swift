//
//  ViewController.swift
//  Telegram_charts
//
//  Created by Zherdeva Elena on 12/03/2019.
//  Copyright © 2019 Zherdeva Elena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var numberOfCharts: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCharts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        return cell
    }
    
    
    @IBAction func goToChart(_ sender: Any) {
        performSegue(withIdentifier: "goToChartViewCont", sender: self)
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        do {
            let destinationViewController = segue.destination as! ChartViewController
            destinationViewController.charts = try getDataFromFile()
            numberOfCharts = destinationViewController.charts.count
            
        } catch {
            fatalError("Can't parse json data")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW LOAD")
        do {
            var charts: [ChartData] = try getDataFromFile()
            numberOfCharts = charts.count
            print("number")
            print(numberOfCharts)
            
        } catch {
            fatalError("Can't parse json data")
        }
        print("viewDidLoad")
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

