//
//  InterventionTypeReportViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 18/10/21.
//

import UIKit
import Charts

class InterventionTypeReportViewController: UIViewController {
    
    @IBOutlet var pieChart: PieChartView!
    let dataController = SessionReportController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateReport(timespan: String){
        var entryList:  [PieChartDataEntry] = []
        
        let rawData = dataController.getReportData(reportType: "intervention", timespan: timespan)
        let limit = rawData.values?.count ?? 0
        
        for index in 0..<limit {
            
            let entry = PieChartDataEntry(value: Double((rawData.values?[index])!), label: rawData.labels?[index])
            entryList.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: entryList, label: nil)
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueColors = [UIColor.black]
        let data = PieChartData(dataSets: [dataSet])
        pieChart.data = data
        pieChart.entryLabelColor = UIColor.black

        pieChart.notifyDataSetChanged()
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
