//
//  ThanatologistMainViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 05/10/21.
//

import UIKit

class ThanatologistMainViewController: UIViewController {
    
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var containerView: UIView!
    
    private lazy var tableController: ThanatologistMenuTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "thanatologistMenuTable") as! ThanatologistMenuTableViewController
        
        self.add(asChildViewController: viewController)

        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
