//
//  AdminMenuViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 06/10/21.
//

import UIKit

class AdminMenuViewController: UIViewController {

    
    @IBOutlet var containerView: UIView!
    @IBOutlet var helloLabel: UILabel!
    
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
        helloLabel.text = "Hola, \(currentSession!.name!)!"
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = containerView.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        currentSession = nil
        helloLabel.text = ""
        performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
}
