//
//  AdminMainViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 05/10/21.
//

import UIKit

class AdminMainViewController: UIViewController {
    
    @IBOutlet var viewContainer: UIView!
    
    @IBOutlet var viewSwitch: UISegmentedControl!
    
    @IBAction func logout(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    @objc private func updateView() {
        if viewSwitch.selectedSegmentIndex == 1 {
            remove(asChildViewController: staffTableController)
            add(asChildViewController: reportsController)
        } else {
            remove(asChildViewController: reportsController)
            add(asChildViewController: staffTableController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = viewContainer.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewContainer.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private lazy var staffTableController: UINavigationController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "StaffRootView") as! UINavigationController

        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var reportsController: UINavigationController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "ReportsRootView") as! UINavigationController

        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        viewSwitch.removeAllSegments()
        viewSwitch.insertSegment(withTitle: "Staff", at: 0, animated: false)
        viewSwitch.insertSegment(withTitle: "Reportes", at: 1, animated: false)
        viewSwitch.addTarget(self, action: #selector(updateView), for: .valueChanged)
         viewSwitch.selectedSegmentIndex = 0
        
        updateView()
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
