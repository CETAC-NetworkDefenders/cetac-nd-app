//
//  ServiceTypeReportViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 18/10/21.
//

import UIKit

import Charts

class GlobalRecoveryFeeReportViewController: UIViewController {
    
    @IBOutlet var barChart: BarChartView!
    let dataController = FeesReportController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateReport(timespan: String){
        
        var entryList:  [BarChartDataEntry] = []
        
        let rawData = dataController.getReportData(reportType: "global", timespan: timespan)
        let limit = rawData.values?.count ?? 0
        
        for index in 0..<limit {
            let entry = BarChartDataEntry(x: Double(index), y: Double((rawData.values?[index])!))
            entryList.append(entry)
        }
        
        let dataSet = BarChartDataSet(entries: entryList, label: nil)
        dataSet.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        
        
        barChart.xAxis.labelFont = UIFont.systemFont(ofSize: 13.0)
        barChart.xAxis.labelTextColor = .black
        barChart.xAxis.granularity = 1
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelCount = rawData.labels?.count ?? 0
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: rawData.labels!)
        
        barChart.leftAxis.axisMinimum = 0
        barChart.leftAxis.granularity = 1
        barChart.rightAxis.axisMinimum = 0
        barChart.rightAxis.granularity = 1

        barChart.notifyDataSetChanged()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

 
