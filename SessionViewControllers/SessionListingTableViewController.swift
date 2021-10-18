//
//  SessionTableViewController.swift
//  cetac-nd-app
//
//  Created by Iñigo Zepeda on 10/7/21.
//

import UIKit

class SessionListingTableViewController: UITableViewController {
    
    var parentRef: UserDetailViewController?
    
    let sessionInfoController = SessionController()
    //Permte hacer peticiones
    var sessionSummaryList: SessionSummaryList?
    //Permite almancenar respuesta de las peticiones
    var selectedUserId: Int?
    
    var selectedSessionId: Int?
    
    override func viewDidLoad() {
        self.parentRef = self.parent as? UserDetailViewController
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func viewDidAppear(_ animated: Bool) {
        print("View just appeared")
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSession))

        parentRef!.navigationItem.rightBarButtonItem = addBarButton

    }
    
    @objc func addSession(){
        parentRef!.performSegue(withIdentifier: "showCreateSession", sender: parentRef)
    }
    
    func updateData(){
        let userId = self.selectedUserId!
        self.sessionSummaryList = nil
        self.tableView.reloadData()
        print("Getting the listing info")
        sessionInfoController.fetchListing(id: userId, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let sessionList):
                        self.sessionSummaryList = sessionList
                        print("Successful listing request")
                        self.tableView.reloadData()
                    
                    case .failure(let error):
                        print(error)
                }
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if sessionSummaryList == nil{
            return 0
        }
        else if sessionSummaryList!.sessionList == nil{
            return 0
        }
        else{
            return sessionSummaryList!.sessionList!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath)
        
        let name = sessionSummaryList!.sessionList![indexPath.row].intervention_type
        let date = sessionSummaryList!.sessionList![indexPath.row].session_date
        cell.textLabel!.text = name
        cell.detailTextLabel!.text = date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSessionId = sessionSummaryList?.sessionList?[indexPath.row].session_id
        performSegue(withIdentifier: "showSessionDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SessionDetailViewController{
            let vc = segue.destination as? SessionDetailViewController
            vc!.sessionId = self.selectedSessionId
        }
    }

}
