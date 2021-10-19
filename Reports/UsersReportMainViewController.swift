//
//  UsersReportMainViewController.swift
//  cetac-nd-app
//
//  Created by user194238 on 10/18/21.
//

import UIKit

class UsersReportMainViewController: UIViewController {

    @IBOutlet var reportTypeSelector: UISegmentedControl!
    @IBOutlet var timeFrameSlider: UISlider!
    @IBOutlet var reportContainer: UIView!
    
    let timeFrameMapping = [
        1: "week",
        2: "month",
        3: "year"
    ]
    
    private lazy var genderReportView: GenderReportViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "genderReportView") as! GenderReportViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var usersThanatologistReportView: UsersByThanatologistTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "usersThanatologistReportView") as! UsersByThanatologistTableViewController
        
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
            remove(asChildViewController: usersThanatologistReportView)
            add(asChildViewController: genderReportView)
        } else if reportTypeSelector.selectedSegmentIndex == 1 {
            remove(asChildViewController: genderReportView)
            add(asChildViewController: usersThanatologistReportView)
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
        genderReportView.updateReport(timespan: timespan)
        usersThanatologistReportView.updateReport(timespan: timespan)
    }
    
}
