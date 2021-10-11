//
//  UserTableViewController.swift
//  cetac-nd-app
//
//  Created by user194238 on 10/7/21.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    let userInfoController = UserController()
    var userSummaryList: UserSummaryList?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Llegue aqui 1")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        updateData(staffId: "1")
    }
    
    func updateData(staffId: String) {
        self.userSummaryList = nil;
        self.tableView.reloadData()
        print("Updating data")
        userInfoController.fetchListing(staffId: staffId, completition: { (result) in DispatchQueue.main.async {
                switch result {
                    case.success(let userList):
                        self.userSummaryList = userList
                        self.userSummaryList?.buildGroups()
                        self.tableView.reloadData()
                        print("Updated")
                    case.failure(let error):
                        print(error)
                    }
                }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return userSummaryList == nil ? Int(0) : userSummaryList!.userGroup!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userSummaryList == nil ? Int(0) : userSummaryList!.userGroup![section].userList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let section = userSummaryList!.userGroup![indexPath.section]
        let name = section.userList[indexPath.row].getName()
        cell.textLabel!.text = name
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userSummaryList!.userGroup![section].letter
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
