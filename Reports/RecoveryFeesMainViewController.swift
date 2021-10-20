//
//  RecoveryFeeMainViewController.swift
//  cetac-nd-app
//
//  Created by user197499 on 10/18/21.
//

import UIKit

class RecoveryFeeMainViewController: UIViewController {

    @IBOutlet var outletSegment: UISegmentedControl!
    @IBOutlet var outletSlider: UISlider!
    @IBOutlet var outletContainer: UIView!
    
    let timeFrameMapping = [
        1: "week",
        2: "month",
        3: "year"
    ]
    
    private lazy var globalRecoveryFeeReportView: GlobalRecoveryFeeReportViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "globalRecoveryFeeReportView") as! GlobalRecoveryFeeReportViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    //Instancia los controladores hijos
    private lazy var thanatologistRecoveryFeeReportView: ThanatologistRecoveryFeeViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "thanatologistRecoveryFeeReportView") as! ThanatologistRecoveryFeeViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outletSegment.addTarget(self, action: #selector(changeReport), for: .valueChanged)
        
        outletSegment.selectedSegmentIndex = 0
        changeReport()
        
        actionChangeTime(outletSlider)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func changeReport(){
        if outletSegment.selectedSegmentIndex == 0 {
            remove(asChildViewController: thanatologistRecoveryFeeReportView)
            add(asChildViewController: globalRecoveryFeeReportView)
        } else {
            remove(asChildViewController: globalRecoveryFeeReportView)
            add(asChildViewController: thanatologistRecoveryFeeReportView)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = outletContainer.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController){
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    
    @IBAction func actionChangeTime(_ sender: UISlider) {
        
        let updateValue = sender.value.rounded(.toNearestOrAwayFromZero)
        sender.value = updateValue
        let timespan = timeFrameMapping[Int(updateValue)]!
        print(timespan)
        globalRecoveryFeeReportView.updateReport(timespan: timespan)
        
        thanatologistRecoveryFeeReportView.updateReport(timespan: timespan)
        
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
 
 
