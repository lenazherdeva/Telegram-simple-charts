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
    let chartNames: [String] = ["Graph1", "Graph2", "Graph3", "Graph4", "Graph5"]
    var charts: [ChartData] = []
    var selectedGraph: Int = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCharts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = chartNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedGraph = indexPath.row
        performSegue(withIdentifier: "goToChartViewCont", sender: self)
        print(chartNames[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ChartViewController
        destinationViewController.charts = charts
        destinationViewController.selectedGraph = selectedGraph
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            charts = try getDataFromFile()
            numberOfCharts = charts.count
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

