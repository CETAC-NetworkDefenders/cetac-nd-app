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
    
    private lazy var listingTableController: StaffListingTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "staffListingTable") as! StaffListingTableViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(asChildViewController: listingTableController)
        accessLevelSelector.addTarget(self, action: #selector(updateChildTable), for: .valueChanged)
        accessLevelSelector.selectedSegmentIndex = 0
        
        updateChildTable()
    }
    
    @objc func updateChildTable(){
        let selectedAccessLevel = accessLevels[accessLevelSelector.selectedSegmentIndex]
        listingTableController.updateData(accessLevel: selectedAccessLevel)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = containerView.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
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
