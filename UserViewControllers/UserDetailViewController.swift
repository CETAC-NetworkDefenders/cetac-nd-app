//
//  UserDetailViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 10/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var segmentControl: UISegmentedControl!
    
    
    private lazy var userInformationController: UserInformationViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "userInformationView") as! UserInformationViewController
        
        self.add(asChildViewController: viewController)


        return viewController
    }()

    private lazy var sessionListingController: SessionListingTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "sessionTableViewController") as! SessionListingTableViewController
        
        self.add(asChildViewController: viewController)


        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "Información del Usuario", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Sesiones", at: 1, animated: false)
        segmentControl.addTarget(self, action: #selector(toggleView), for: .valueChanged)
        
        self.add(asChildViewController: userInformationController)
        segmentControl.selectedSegmentIndex = 0
    }
    
    @objc func toggleView() -> Void{
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sessionListingController)
            add(asChildViewController: userInformationController)
        } else {
            remove(asChildViewController: userInformationController)
            add(asChildViewController: sessionListingController)
        }
    }
    
    func add(asChildViewController viewController: UIViewController){
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = containerView.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
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
