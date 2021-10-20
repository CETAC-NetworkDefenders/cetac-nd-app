//
//  ReopenRecordTableViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 17/10/21.
//

import UIKit

class ReopenRecordTableViewController: UITableViewController {
    
    var userSummaryList: UserSummaryList?
    let userController = UserController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userController.fetchListing(staffId: nil, completition: { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let userList):
                        self.userSummaryList = userList
                        print("Successful listing request")
                        self.tableView.reloadData()
                    
                    case .failure(let error):
                        print(error)
                }
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userSummaryList?.userList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldUserCell", for: indexPath)

        cell.textLabel?.text = userSummaryList?.userList?[indexPath.row].getName()
        cell.detailTextLabel?.text = userSummaryList?.userList?[indexPath.row].birthDate
        
        return cell
    }
    
}
