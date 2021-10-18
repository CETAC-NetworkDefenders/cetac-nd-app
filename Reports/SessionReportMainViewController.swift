//
//  SessionReportMainViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 18/10/21.
//

import UIKit

class SessionReportMainViewController: UIViewController {
    
    @IBOutlet var reportTypeSelector: UISegmentedControl!
    @IBOutlet var timeFrameSlider: UISlider!
    @IBOutlet var reportContainer: UIView!
    
    let timeFrameMapping = [
        1: "week",
        2: "month",
        3: "year"
    ]
    
    private lazy var motiveReportView: MotiveReportTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "motiveReportView") as! MotiveReportTableViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var serviceReportView: ServiceTypeReportViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "serviceReportView") as! ServiceTypeReportViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    private lazy var interventionReportView: InterventionTypeReportViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "interventionReportView") as! InterventionTypeReportViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        reportTypeSelector.addTarget(self, action: #selector(changeReport), for: .valueChanged)
        
        reportTypeSelector.selectedSegmentIndex = 0
        changeReport()
        
        timespanChange(timeFrameSlider)
    }
    
    @objc func changeReport(){
        if reportTypeSelector.selectedSegmentIndex == 0 {
            remove(asChildViewController: motiveReportView)
            remove(asChildViewController: interventionReportView)
            add(asChildViewController: serviceReportView)
        } else if reportTypeSelector.selectedSegmentIndex == 1 {
            remove(asChildViewController: serviceReportView)
            remove(asChildViewController: interventionReportView)
            add(asChildViewController: motiveReportView)
        } else if reportTypeSelector.selectedSegmentIndex == 2 {
            remove(asChildViewController: serviceReportView)
            remove(asChildViewController: motiveReportView)
            add(asChildViewController: interventionReportView)
        }
    }
    
    
    private func add(asChildViewController viewController: UIViewController) {
        
        addChild(viewController)
        view.addSubview(viewController.view)

        viewController.view.frame = reportContainer.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    @IBAction func timespanChange(_ sender: UISlider) {
        let updateValue = sender.value.rounded(.toNearestOrAwayFromZero)
        sender.value = updateValue
        let timespan = timeFrameMapping[Int(updateValue)]!
        print(timespan)
        motiveReportView.updateReport(timespan: timespan)
        interventionReportView.updateReport(timespan: timespan)
        serviceReportView.updateReport(timespan: timespan)
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
