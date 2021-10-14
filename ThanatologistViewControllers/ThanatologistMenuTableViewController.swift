//
//  ThanatologistMenuTableViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 10/10/21.
//

import UIKit

class ThanatologistMenuTableViewController: UITableViewController {
    
    var container: ThanatologistMainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        container = self.parent as? ThanatologistMainViewController

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                container?.performSegue(withIdentifier: "showUserListing", sender: container)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                container?.performSegue(withIdentifier: "showNewUser", sender: container)
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
