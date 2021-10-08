//
//  StaffListingTableViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 07/10/21.
//

import UIKit

class StaffListingTableViewController: UITableViewController {
    
    let staffInfoController = StaffController()
    var staffSummaryList: StaffSummaryList?
    var container: StaffListingViewController?
    var accessLevel: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = self.parent as? StaffListingViewController

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateData(accessLevel: accessLevel!)
    }

    func updateData(accessLevel: String){
        self.accessLevel = accessLevel
        self.staffSummaryList = nil
        self.tableView.reloadData()

        staffInfoController.fetchListing(accessLevel: accessLevel, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let staffList):
                        self.staffSummaryList = staffList
                        self.staffSummaryList?.buildGroups()
                        self.tableView.reloadData()
                    
                    case .failure(let error):
                        print(error)
                }
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return staffSummaryList == nil ? Int(0) : staffSummaryList!.staffGroup!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return staffSummaryList == nil ? Int(0) : staffSummaryList!.staffGroup![section].staffList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath)
        let section = staffSummaryList!.staffGroup![indexPath.section]
        let name = section.staffList[indexPath.row].getName()
        cell.textLabel!.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return staffSummaryList!.staffGroup![section].letter
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = staffSummaryList!.staffGroup![indexPath.section]
        let id = section.staffList[indexPath.row].id
        container!.selectedStaffId = id
        container?.performSegue(withIdentifier: "showStaffDetail", sender: container)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
