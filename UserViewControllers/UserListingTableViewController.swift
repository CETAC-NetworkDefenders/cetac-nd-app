//
//  UserListingTableViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 10/10/21.
//

import UIKit

class UserListingTableViewController: UITableViewController {
    
    let userInfoController = UserController()
    var userSummaryList: UserSummaryList?
    var selectedUser: UserSummary?

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentStaff = currentSession!.userId!
        updateData(staffId: currentStaff)
    }

    // MARK: - Table view data source

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = userSummaryList!.userGroup![indexPath.section]
        self.selectedUser = section.userList[indexPath.row]
        print("Record ID \(self.selectedUser!.recordId)")
        performSegue(withIdentifier: "showUserDetail", sender: self)
    }

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is UserDetailViewController {
            let vc = segue.destination as? UserDetailViewController
            vc?.selectedUser = self.selectedUser
        }
    }
    

}
