//
//  AdminMenuTableViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 06/10/21.
//

import UIKit

class AdminMenuTableViewController: UITableViewController {
    
    var container: AdminMenuViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        container = self.parent as? AdminMenuViewController
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0{
            if indexPath.row == 0 {
                container!.performSegue(withIdentifier: "showStaffListing", sender: container)
            }
        }

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
