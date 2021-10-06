//
//  StaffDetailViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 06/10/21.
//

import UIKit

class StaffDetailViewController: UIViewController {
    
    var parentRef: StaffListingViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        parentRef = self.parent!.parent as? StaffListingViewController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        parentRef!.filterStack.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        parentRef!.filterStack.isHidden = false
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
