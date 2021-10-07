//
//  AdminMenuViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 06/10/21.
//

import UIKit

class AdminMenuViewController: UIViewController {

    
    @IBOutlet var containerView: UIView!
    
    private lazy var tableController: AdminMenuTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "adminMenuTable") as! AdminMenuTableViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        add(asChildViewController: tableController)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = containerView.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToLogin", sender: self)
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
