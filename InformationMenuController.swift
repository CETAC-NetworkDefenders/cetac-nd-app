//
//  InformationMenuController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 04/10/21.
//

import UIKit

class InformationMenuController: UITableViewController {
    
    var serviceList: ServiceGroup?
    var cellsCount: Int? = 0
    var selectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.backgroundView = UIImageView(image: UIImage(named:"table-background"))
        //self.tableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.serviceList = services![globalSelectedTab!]
        self.cellsCount = self.serviceList!.services.count
        self.title = self.serviceList!.groupName
        self.tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsCount ?? Int(0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath)
        let service = serviceList!.services[indexPath.row]
        cell.textLabel?.text = service.serviceName
        cell.textLabel?.textColor = UIColor.white
        cell.imageView?.image = UIImage(named: "flecha-right-blue")
        cell.imageView?.tintColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "ShowService", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ServiceInformationControlller {
            let vc = segue.destination as? ServiceInformationControlller
            let service = self.serviceList!.services[self.selectedRow]
            vc?.service = service
        }
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
