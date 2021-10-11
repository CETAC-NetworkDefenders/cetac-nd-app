//
//  StaffListingViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 06/10/21.
//

import UIKit

class StaffListingViewController: UIViewController {

    @IBOutlet var accessLevelSelector: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    let accessLevels = ["thanatologist", "admin", "admin_support"]
    let staffInfoController = StaffController()
    var selectedStaffId: Int?
    
    private lazy var listingTableController: StaffListingTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "staffListingTable") as! StaffListingTableViewController
        
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = containerView.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)

        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accessLevelSelector.addTarget(self, action: #selector(updateChildTable), for: .valueChanged)
        accessLevelSelector.selectedSegmentIndex = 0
        
        updateChildTable()
    }
    
    @objc func updateChildTable(){
        let selectedAccessLevel = accessLevels[accessLevelSelector.selectedSegmentIndex]
        listingTableController.updateData(accessLevel: selectedAccessLevel)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is StaffDetailViewController {
            let vc = segue.destination as? StaffDetailViewController
            vc?.selectedStaffId = self.selectedStaffId
        }
    }

}
