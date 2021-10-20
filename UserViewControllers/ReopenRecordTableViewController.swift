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
    var selectedRecord: Int?

    let alertConfirmation = UIAlertController(title: "Confirmar", message: "Esta seguro que quiere reabrir un expediente para este usuario?", preferredStyle: .alert)
    
    let alertDone = UIAlertController(title: "Expediente reabierto", message: "Puede agendar una sesion de encuadre para el usuario", preferredStyle: .alert)
    
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
        
        alertDone.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: nil))
        
        alertConfirmation.addAction(UIAlertAction(title: "Si", style: .default, handler: { (action: UIAlertAction!) in
            self.userController.updateRecord(staff_id: String(currentSession!.userId!), record_id: String(self.selectedRecord!), completion: {
                print("User updated")
            })
        }))
        alertConfirmation.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecord = userSummaryList?.userList?[indexPath.row].recordId
        self.present(alertConfirmation, animated: true)
    }
}
